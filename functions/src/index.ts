/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// Load environment variables from .env.local (only in development)


import * as dotenv from "dotenv";
dotenv.config();

import * as functions from "firebase-functions/v2/https";
import { setGlobalOptions } from "firebase-functions/v2";
import { GoogleGenerativeAI } from "@google/generative-ai";
import { logger } from "firebase-functions";


// Initialize Gemini API with environment variable from .env.local or Firebase Secrets
const apiKey = process.env.gemini_api_key || process.env.GEMINI_API_KEY;
if (!apiKey) {
    logger.error("Gemini API key not configured. Set 'gemini_api_key' in .env.local or 'GEMINI_API_KEY' in environment");
}


const genAI = new GoogleGenerativeAI(apiKey || "");

setGlobalOptions({ maxInstances: 5 });


export const generatedText = functions.onCall(async (request) => {
    try {
        const prompt = request.data.prompt?.trim();

        if (!prompt) {
            throw new functions.HttpsError("invalid-argument", "Prompt is required and cannot be empty");
        }

        if (prompt.length > 5000) {
            throw new functions.HttpsError("invalid-argument", "Prompt exceeds maximum length of 5000 characters");
        }

        logger.info("Processing prompt request", { promptLength: prompt.length });

        const model = genAI.getGenerativeModel({
            model: "gemini-1.5-flash"
        });

        const result = await model.generateContent(prompt);
        const response = result.response;

        if (!response || !response.text()) {
            throw new functions.HttpsError("internal", "Failed to generate response from Gemini API");
        }

        logger.info("Response generated successfully");

        return {
            text: response.text(),
            success: true
        };
    } catch (error) {
        logger.error("Error in generatedText function", { error });
        
        if (error instanceof functions.HttpsError) {
            throw error;
        }
        
        throw new functions.HttpsError("internal", "An unexpected error occurred while generating text");
    }
})
// Start writing functions
// https://firebase.google.com/docs/functions/typescript

// Cost control: Maximum containers running at once (per-function limit)
// For cost savings with Gemini API, keep this relatively low

// For Firebase Secrets Manager (production deployment):
// 1. Upgrade project to Blaze plan: https://console.firebase.google.com/project/buuble-3aae3/usage/details
// 2. Deploy secret: firebase functions:secrets:set GEMINI_API_KEY
// 3. Use in code: process.env.GEMINI_API_KEY
//
// For local development:
// 1. Create .env.local file with: gemini_api_key=YOUR_KEY
// 2. dotenv package will automatically load it







import * as dotenv from 'dotenv';
import * as path from 'path';
// import { GoogleGenerativeAI } from "@google/generative-ai"; 

// Load environment variables
dotenv.config({ path: path.resolve(__dirname, '../../.env.local') });

async function debugGemini() {
    const apiKey = process.env.gemini_api_key || process.env.GEMINI_API_KEY;
    console.log("API Key loaded:", apiKey ? "YES" : "NO");
    if (apiKey) {
        console.log("API Key starts with:", apiKey.substring(0, 4));
        console.log("API Key length:", apiKey.length);
    } else {
        console.error("No API Key found!");
        return;
    }

    const url = `https://generativelanguage.googleapis.com/v1beta/models?key=${apiKey}`;

    try {
        console.log("Fetching available models via raw REST API...");
        const response = await fetch(url);
        if (!response.ok) {
            console.error(`Error: ${response.status} ${response.statusText}`);
            console.error(await response.text());
        } else {
            const json: any = await response.json();
            console.log("Models found:");
            if (json.models) {
                json.models.forEach((m: any) => console.log(` - ${m.name}`));
            } else {
                console.log(JSON.stringify(json, null, 2));
            }
        }

    } catch (error: any) {
        console.error("Fetch error:", error);
    }
}

debugGemini();

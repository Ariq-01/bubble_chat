
// import * as admin from 'firebase-admin'; // Unused
import * as dotenv from 'dotenv';
import * as path from 'path';

// Load environment variables
dotenv.config({ path: path.resolve(__dirname, '../../.env.local') });

// Configuration
const PROJECT_ID = 'buuble-3aae3';
const REGION = 'us-central1';
const FUNCTION_NAME = 'generatedText';

// URL for the local emulator
const EMULATOR_HOST = '127.0.0.1:5005';
const URL = `http://${EMULATOR_HOST}/${PROJECT_ID}/${REGION}/${FUNCTION_NAME}`;

async function testChat() {
    const prompt = "Hello, tell me a short joke.";
    console.log(`Sending prompt: "${prompt}"`);
    console.log(`Target URL: ${URL}`);

    // Verify API key is present (just a warning locally)
    if (!process.env.gemini_api_key && !process.env.GEMINI_API_KEY) {
        console.warn("WARNING: GEMINI_API_KEY not found in test script environment.");
    }

    try {
        // Use global fetch (Node 18+)
        const response = await fetch(URL, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                data: {
                    prompt: prompt
                }
            })
        });

        if (!response.ok) {
            console.error(`Error: ${response.status} ${response.statusText}`);
            const text = await response.text();
            console.error("Body:", text);
            return;
        }

        const json = await response.json() as any;
        console.log("Response received:");
        console.log(JSON.stringify(json, null, 2));

        if (json.result && json.result.text) {
            console.log("\n--- AI Response ---");
            console.log(json.result.text);
            console.log("-------------------");
        }

    } catch (error) {
        console.error("Failed to call function. Is the emulator running?");
        console.error(error);
    }
}

testChat();

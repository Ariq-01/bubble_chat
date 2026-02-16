/*
  npm i bytez.js || yarn add bytez.js
*/

import Bytez from "bytez.js"

const key = "b67c77e4f8e1ce3ced7b6af1fed9db83"
const sdk = new Bytez(key)

// choose Mistral-7B-Instruct-v0.3
const model = sdk.model("mistralai/Mistral-7B-Instruct-v0.3");

// send input to model
(async () => {
    try {
        const { error, output } = await model.run([
            {
                "role": "user",
                "content": "Hello bro, tell me some jokes of ai apples in 2026"
            }
        ])
        console.log({ error, output });
    } catch (e) {
        console.error("Error running model:", e);
    }
})();
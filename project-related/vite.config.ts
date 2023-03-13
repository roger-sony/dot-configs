import react from "@vitejs/plugin-react";
import { readFileSync } from "fs";
import { resolve } from "path";
import { defineConfig } from "vite";
import dynamicImport from "vite-plugin-dynamic-import";
import { viteExternalsPlugin } from "vite-plugin-externals";

const HTTPS = process.env.HTTPS !== "false";
const HOST = process.env.HOST || "dart.cogitai.local";
const PORT = parseInt(process.env.PORT || "3000");
const OUTDIR = process.env.OUTDIR;

export default defineConfig(({ command, mode }) => ({
  resolve: {
    alias: {
      "/@viz": resolve(__dirname, "./src/viz"),
      "/@/": resolve(__dirname, "./src"),
      "/@/components": resolve(__dirname, "./src/components"),
      "/@/components/*": resolve(__dirname, "./src/components/*"),
      "/@/generated": resolve(__dirname, "./src/generated"),
      "/@/generated/*": resolve(__dirname, "./src/generated/*"),
      "/@/hooks": resolve(__dirname, "./src/hooks"),
      "/@/hooks/*": resolve(__dirname, "./src/hooks/*"),
      "/@/util": resolve(__dirname, "./src/util"),
      "/@/util/*": resolve(__dirname, "./src/util/*"),
      viz: resolve(__dirname, "./src/viz"),
      "/@iframe-code-editor": resolve(__dirname, "./iframes/typescript-editor/src"),
    },
  },

  plugins: [
    viteExternalsPlugin({
      danfojs: "dfd",
      numjs: "nj",
      "plotly.js": "Plotly",
      typescript: "ts",
    }),
    react(),
    dynamicImport(),
  ],

  build: {
    outDir: OUTDIR,
    target: "esnext",
    sourcemap: mode === "development",
    minify: mode === "development" ? false : "esbuild",

    commonjsOptions: {
      exclude: ["plotly.js", "danfojs", "numjs", "typescript"],
    },
    rollupOptions: {
      // make sure to externalize deps that shouldn't be bundled
      // into your library
      external: ["plotly.js", "danfojs", "numjs", "typescript"],
      output: {
        // Provide global variables to use in the UMD build
        // for externalized deps
        globals: {
          danfojs: "dfd",
          numjs: "nj",
          "plotly.js": "Plotly",
          typescript: "ts",
        },
      },
    },
  },
  server: {
    open: false,
    host: HOST,
    port: PORT,
    https:
      command === "serve" && HTTPS
        ? {
            key: readFileSync("../../compose/ingress/https/conf.d/certs/dart-key.pem"),
            cert: readFileSync("../../compose/ingress/https/conf.d/certs/dart.pem"),
          }
        : undefined,
  },
}));

import cors from 'cors';
import dotenv from 'dotenv';
import express, { Express, NextFunction, Request, Response } from 'express';
import authRoutes from './routes/auth';
import dbRoutes from './routes/db/db';
import { JSend } from './shared/jsend';
import path from 'path';

// dotenv config
dotenv.config();

// https://github.com/GoogleChromeLabs/jsbi/issues/30
// @ts-ignore: Unreachable code error
BigInt.prototype["toJSON"] = function () {
    return this.toString();
};

// Create app
const app: Express = express();
app.use(cors());
app.use(express.json({ limit: '20mb' }));

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/db', dbRoutes);

// Serve Angular build
const siteName = process.env.SITE_NAME ? `/${process.env.SITE_NAME}` : '/';
app.use(siteName, express.static(path.join(__dirname, 'public', 'browser')));
app.get(`${siteName}*`, (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'browser', 'index.html'));
});

// Error handling
function errorHandler(err: any, req: Request, res: Response, next: NextFunction) {
    console.error(err);
    res.status(500).json(JSend.error(err?.message || err));
}
app.use(errorHandler);

// Listen
const port = process.env.PORT || 8080;
const server = app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});

// --- SIGTERM HANDLER ---
process.on('SIGTERM', () => {
    console.log(`SIGTERM ricevuto: chiudo server...`);
    server.close(() => {
        console.log(`SServer chiuso, esco.`);
        process.exit(0);
    });
});

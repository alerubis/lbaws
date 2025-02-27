import cors from 'cors';
import dotenv from 'dotenv';
import express, { Express, NextFunction, Request, Response } from 'express';
import authRoutes from './routes/auth';
import apiRoutes from './routes/api';
import { JSend } from './shared/jsend';

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
app.use(express.json());

// Error handling
function errorHandler(err: any, req: Request, res: Response, next: NextFunction) {
    console.error(err);
    res.status(500).json(JSend.error(err?.message || err));
}
app.use(errorHandler);

// Routes
app.get("/", (req: Request, res: Response) => {
    res.send("It works!");
});
app.use('/auth', authRoutes);
app.use('/api', apiRoutes);

// Listen
const port = process.env.PORT || 8080;
app.listen(port, () => {
    console.log(`[server]: Server is running at http://localhost:${port}`);
});

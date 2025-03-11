import { PrismaClient } from '@prisma/client';
import express from 'express';
import { authenticateToken, getToken } from '../shared/auth';
import { wrapAsync } from '../shared/functions';
import { JSend } from '../shared/jsend';

const router = express.Router();

const prisma = new PrismaClient();

router.post("/login", wrapAsync(async (req: any, res: any) => {

    const username: string = req.body.username;
    const password: string = req.body.password;

    if (!username) {
        res.status(400).json(JSend.error('Missing username!'));
        return;
    }

    if (!password) {
        res.status(400).json(JSend.error('Missing password!'));
        return;
    }

    const user = await prisma.user.findFirst({ where: { username: username } });

    if (!user) {
        res.status(400).json(JSend.error('User not found!'));
        return;
    }

    if (user.password !== password) {
        res.status(400).json(JSend.error('Invalid password!'));
        return;
    }

    const token = getToken(user.id, user.username, user.team_id);
    res.status(200).json(JSend.success({ token: token, user: user }));

}));

router.post('/get-user-from-token', authenticateToken(), wrapAsync(async (req: any, res: any) => {

    const username: string = req.user.username;

    if (!username) {
        res.status(400).json(JSend.error('Missing username!'));
        return;
    }

    const user = await prisma.user.findFirst({ where: { username: username } });

    if (!user) {
        res.status(400).json(JSend.error('User not found!'));
        return;
    }

    res.status(200).json(JSend.success(user));

}));

export default router;

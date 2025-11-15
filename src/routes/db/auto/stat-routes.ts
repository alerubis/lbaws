import { stat } from './../../../../node_modules/.prisma/client/index.d';
import { PrismaClient } from '@prisma/client';
import express from 'express';
import { authenticateToken } from '../../../shared/auth';
import { wrapAsync } from '../../../shared/functions';
import { JSend } from '../../../shared/jsend';

const prisma = new PrismaClient();

const router = express.Router();
router.use(authenticateToken());

router.post('/read', wrapAsync(async (req: any, res: any) => {
    const response = await prisma.$transaction(async (tx) => {
        const rows = await tx.stat.findMany({
            skip: req.body?.skip,
            take: req.body?.take || 1,
            where: req.body?.where,
            orderBy: req.body?.orderBy,
        });
        const count = await tx.stat.count({ where: req.body?.where });
        return {
            rows: rows,
            count: count,
        };
    },{timeout: 15000});
    res.status(200).json(JSend.success(response));
}));

router.post('/update', wrapAsync(async (req: any, res: any) => {
    const response = await prisma.$transaction(async (tx) => {
        const updatedRow = await tx.stat.update({
            where: {
                stat_id: req.body.stat_id
            },
            data: {
                ...req.body,
                stat_id: req.user.stat_id,
            }
        });
        return updatedRow;
    });
    res.status(200).json(JSend.success(response));
}));
export default router;

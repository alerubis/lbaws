import { PrismaClient } from '@prisma/client';
import express from 'express';
import { authenticateToken } from '../../../shared/auth';
import { wrapAsync } from '../../../shared/functions';
import { JSend } from '../../../shared/jsend';

const prisma = new PrismaClient();

const router = express.Router();
router.use(authenticateToken());

router.post('/create', wrapAsync(async (req: any, res: any) => {
    const createdRow = await prisma.$transaction(async (tx) => {
        const createdRow = await tx.dz_turnover.create({ data: req.body });
        return createdRow;
    });
    res.status(200).json(JSend.success(createdRow));
}));

router.post('/read', wrapAsync(async (req: any, res: any) => {
    const response = await prisma.$transaction(async (tx) => {
        const rows = await tx.dz_turnover.findMany({
            skip: req.body?.skip,
            take: req.body?.take || 1,
            where: req.body?.where,
            orderBy: req.body?.orderBy || { id: 'desc' },
        });
        const count = await tx.dz_turnover.count({ where: req.body?.where });
        return {
            rows: rows,
            count: count,
        };
    });
    res.status(200).json(JSend.success(response));
}));

router.post('/update', wrapAsync(async (req: any, res: any) => {
    const updatedRow = await prisma.$transaction(async (tx) => {
        const updatedRow = await tx.dz_turnover.update({ where: { id: req.body.id }, data: req.body });
        return updatedRow;
    });
    res.status(200).json(JSend.success(updatedRow));
}));

router.post('/delete', wrapAsync(async (req: any, res: any) => {
    const deletedRow = await prisma.$transaction(async (tx) => {
        const deletedRow = await tx.dz_turnover.delete({ where: { id: req.body.id } });
        return deletedRow;
    });
    res.status(200).json(JSend.success(deletedRow));
}));

export default router;

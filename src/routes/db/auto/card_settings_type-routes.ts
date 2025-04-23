import { PrismaClient } from '@prisma/client';
import express from 'express';
import { authenticateToken } from '../../../shared/auth';
import { wrapAsync } from '../../../shared/functions';
import { JSend } from '../../../shared/jsend';

const prisma = new PrismaClient();

const router = express.Router();
router.use(authenticateToken());

export default router;

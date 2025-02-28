import { PrismaClient } from '@prisma/client';
import * as fs from 'fs';
import * as path from 'path';

const prisma = new PrismaClient();

async function generate(outputFolder: string) {

    const infoSchemaTables: any[] = await prisma.$queryRaw`
        SELECT TABLE_NAME
        FROM INFORMATION_SCHEMA.TABLES
        WHERE TABLE_SCHEMA = 'lba'
    `;

    for (const table of infoSchemaTables) {
        const tableName = table.TABLE_NAME;
        console.log(tableName);

        // Import
        let classFileContent = '';
        classFileContent += `import { PrismaClient } from '@prisma/client';\n`;
        classFileContent += `import express from 'express';\n`;
        classFileContent += `import { authenticateToken } from '../../../shared/auth';\n`;
        classFileContent += `import { wrapAsync } from '../../../shared/functions';\n`;
        classFileContent += `import { JSend } from '../../../shared/jsend';\n`;

        // Router setup
        classFileContent += `\nconst prisma = new PrismaClient();\n`;
        classFileContent += `\nconst router = express.Router();`;
        classFileContent += `\nrouter.use(authenticateToken());\n`;

        // Create route
        classFileContent += `\nrouter.post('/create', wrapAsync(async (req: any, res: any) => {\n`;
        classFileContent += `    const createdRow = await prisma.$transaction(async (tx) => {\n`;
        classFileContent += `        const createdRow = await tx.${tableName}.create({ data: req.body });\n`;
        classFileContent += `        return createdRow;\n`;
        classFileContent += `    });\n`;
        classFileContent += `    res.status(200).json(JSend.success(createdRow));\n`;
        classFileContent += `}));\n`;

        // Read route
        classFileContent += `\nrouter.post('/read', wrapAsync(async (req: any, res: any) => {\n`;
        classFileContent += `    const response = await prisma.$transaction(async (tx) => {\n`;
        classFileContent += `        const rows = await tx.${tableName}.findMany({\n`;
        classFileContent += `            skip: req.body?.skip,\n`;
        classFileContent += `            take: req.body?.take || 1,\n`;
        classFileContent += `            where: req.body?.where,\n`;
        classFileContent += `            orderBy: req.body?.orderBy || { id: 'desc' },\n`;
        classFileContent += `        });\n`;
        classFileContent += `        const count = await tx.${tableName}.count({ where: req.body?.where });\n`;
        classFileContent += `        return {\n`;
        classFileContent += `            rows: rows,\n`;
        classFileContent += `            count: count,\n`;
        classFileContent += `        };\n`;
        classFileContent += `    });\n`;
        classFileContent += `    res.status(200).json(JSend.success(response));\n`;
        classFileContent += `}));\n`;

        // Update route
        classFileContent += `\nrouter.post('/update', wrapAsync(async (req: any, res: any) => {\n`;
        classFileContent += `    const updatedRow = await prisma.$transaction(async (tx) => {\n`;
        classFileContent += `        const updatedRow = await tx.${tableName}.update({ where: { id: req.body.id }, data: req.body });\n`;
        classFileContent += `        return updatedRow;\n`;
        classFileContent += `    });\n`;
        classFileContent += `    res.status(200).json(JSend.success(updatedRow));\n`;
        classFileContent += `}));\n`;

        // Delete route
        classFileContent += `\nrouter.post('/delete', wrapAsync(async (req: any, res: any) => {\n`;
        classFileContent += `    const deletedRow = await prisma.$transaction(async (tx) => {\n`;
        classFileContent += `        const deletedRow = await tx.${tableName}.delete({ where: { id: req.body.id } });\n`;
        classFileContent += `        return deletedRow;\n`;
        classFileContent += `    });\n`;
        classFileContent += `    res.status(200).json(JSend.success(deletedRow));\n`;
        classFileContent += `}));\n`;

        // Export router
        classFileContent += `\nexport default router;\n`;

        const filePath = path.join(outputFolder, `${tableName}-routes.ts`);
        fs.writeFileSync(filePath, classFileContent);
    }
}

const outputFolder = process.argv[2];
if (!outputFolder) {
    console.error('Usage: ts-node types-generator.ts <output-folder>');
    process.exit(1);
}

generate(outputFolder)
    .catch((error) => {
        console.error('Error generating: ', error);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });

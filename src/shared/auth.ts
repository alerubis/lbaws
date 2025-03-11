import jwt from 'jsonwebtoken';
import { JSend } from "./jsend";

export function getToken(id: number, username: string, team_id: number) {
    const secret = process.env.SECRET!;
    return jwt.sign({ 'id': id, 'username': username, 'team_id': team_id }, secret);
};

export function authenticateToken() {
    return (req: any, res: any, next: any) => {
        const secret = process.env.SECRET!;
        const authHeader = req.headers.authorization;
        const token = authHeader && authHeader.split(' ')[1];
        if (token == null) {
            return res.status(401).json({ message: 'Missing or invalid token!' });
        }
        jwt.verify(token, secret, (err: any, user: any) => {
            if (err) {
                return res.json(JSend.error(err));
            }
            req.user = user;
            next();
        });
    };
}

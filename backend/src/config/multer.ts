import multer, {Options} from 'multer';
import {resolve} from 'path';
import {randomBytes} from 'crypto';

const multerConfig = {
  fileFilter: (req, file, cb) => {
    const allowedMimes = [
      'image/jpeg',
      'image/jpg',
      'image/png',
    ];

    if (!allowedMimes.includes(file.mimetype)) {
      return cb(new Error('Invalid file type.'));
    }

    return cb(null, true);
  },
  limits: {
    fileSize: 8 * 1024 * 1024,
  },
  storage: multer.diskStorage({
    destination: resolve(__dirname, '..', '..', 'uploads'),
    filename: (req, file, cb) => {
      const filename = `${randomBytes(6).toString('hex')}-${file.originalname}`;

      return cb(null, filename);
    }
  }),
} as Options;

export default multer(multerConfig);

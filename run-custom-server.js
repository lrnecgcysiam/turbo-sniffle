const http = require('http');
const fs = require('fs');
const path = require('path');
const url = require('url');

const directory = './'; // Replace with your directory

const mimeTypes = {
    '.html': 'text/html',
    '.jpeg': 'image/jpeg',
    '.jpg': 'image/jpeg',
    '.png': 'image/png',
    '.mp4': 'video/mp4'
};

http.createServer((req, res) => {
    const requestUrl = url.parse(req.url);
    const fsPath = path.join(directory, decodeURI(requestUrl.pathname));

    fs.stat(fsPath, (err, stats) => {
        if (err) {
            res.writeHead(404);
            res.end('Not Found');
            return;
        }

        if (stats.isDirectory()) {
            fs.readdir(fsPath, (err, files) => {
                if (err) {
                    res.writeHead(500);
                    res.end('Internal Server Error');
                    return;
                }

                res.writeHead(200, { 'Content-Type': 'text/html' });
                res.write('<html><body><ul>');

                files.forEach(file => {
                    const filePath = path.join(fsPath, file);
                    const fileUrl = path.join(requestUrl.pathname, file);
                    const extname = path.extname(file);

                    if (extname === '.mp4') {
                        const thumbnail = path.join(requestUrl.pathname, file.replace('.mp4', '.png'));
                        res.write(`<li><a href="${fileUrl}"><img src="${thumbnail}" width="100"><br>${file}</a></li>`);
                    } else {
                        res.write(`<li><a href="${fileUrl}">${file}</a></li>`);
                    }
                });

                res.end('</ul></body></html>');
            });
        } else {
            const extname = path.extname(fsPath);
            const mimeType = mimeTypes[extname] || 'application/octet-stream';

            res.writeHead(200, { 'Content-Type': mimeType });
            fs.createReadStream(fsPath).pipe(res);
        }
    });
}).listen(8080, () => {
    console.log('Server running at http://127.0.0.1:8080/');
});
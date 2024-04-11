//const http = require('https');
//
//const options = {
//	method: 'GET',
//	hostname: 'indianstockexchange.p.rapidapi.com',
//	port: null,
//	path: '/index.php?id=%7Bscrip-id%7D',
//	headers: {
//		'X-RapidAPI-Key': 'SIGN-UP-FOR-KEY',
//		'X-RapidAPI-Host': 'indianstockexchange.p.rapidapi.com'
//	}
//};
//
//const req = http.request(options, function (res) {
//	const chunks = [];
//
//	res.on('data', function (chunk) {
//		chunks.push(chunk);
//	});
//
//	res.on('end', function () {
//		const body = Buffer.concat(chunks);
//		console.log(body.toString());
//	});
//});
//
//req.end();
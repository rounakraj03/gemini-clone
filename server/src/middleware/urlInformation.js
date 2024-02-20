function urlInformation(req, res, next) {
    console.log("=============================================================================================");
    console.log('Request Path:', req.path);
    console.log('Request Body:', req.body);
    
    const oldWrite = res.write;
    const oldEnd = res.end;
  
    const chunks = [];
  
    res.write = function (chunk) {
      chunks.push(Buffer.from(chunk));
      oldWrite.apply(res, arguments);
    };

    res.on('data', (chunk) => {
        chunks.push(chunk);
      });
    
  
    res.end = function (chunk) {
      if (chunk) {
        chunks.push(Buffer.from(chunk));
      }
  
      const body = Buffer.concat(chunks).toString('utf8');
      console.log('Response Body:', body);
      oldEnd.apply(res, arguments);
      console.log("=============================================================================================\n");
    };
  
    next();
  }

module.exports = {
    urlInformation
}
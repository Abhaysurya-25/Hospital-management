// Route for login
const express = require('express');
const loginRouter = express.Router();

const {encrypt, decrypt} = require('./encryption-handler');
const {executeQuery} = require('./db');


function createUser(req, res){
    console.log(req.body);
    const transformedObj = transformKeys(req.body);
    //insert transformedObj into database hms 
    const encrypted = encrypt(transformedObj.Password);
   
    const sqll = `INSERT INTO User (EmployeeID, Type, Name, Email, Password, Pass_iv) VALUES ('${transformedObj.employee_id}', '${transformedObj.type}', '${transformedObj.Name}', '${transformedObj.Email}', '${encrypted.encrypted_password}', '${encrypted.iv}')`;
    
    executeQuery(sqll, req).then(result => {
        if(result.status != 200){
            res.status(result.status).send(result);
            return;
        }
        res.send(JSON.stringify({ message: 'Signup successful' }));
    }).catch(err => {
        res.status(500).send({ message: 'Error' });
    });
  }
  
  
  function transformKeys(obj) {
    const transformedObj = {};
    for (const key in obj) {
      if (key === 'name') {
        transformedObj['Name'] = obj[key];
      } else if (key === 'email') {
        transformedObj['Email'] = obj[key];
      } else if (key === 'empid') {
        transformedObj['employee_id'] = obj[key];
      } else if (key === 'password') {
        transformedObj['Password'] = obj[key];
      } else if (key === 'type') {
        transformedObj['type'] = obj[key];
      }
      else{
        transformedObj[key] = obj[key];
      }
    }
    return transformedObj;
  }
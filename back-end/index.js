const express = require('express') ;
const app = express() ;
const http = require('http') ;
const server = http.createServer(app) ;
const { Server } = require('socket.io') ;
const io = new Server(server) ;
const cors = require('cors') ;
const port = 3000 ;
const bodyParser = require('body-parser');
const ejs = require('ejs') ;
app.use(cors()) ;  
app.use(bodyParser.urlencoded({extended : true , limit: '25mb'})) ;
app.set('view engine','ejs') ;
app.use(express.static('public'));


app.use(bodyParser.json()) // it return object body is implement of contant by request

server.listen( port  , () => {
    console.log("http://localhost:" + port)
} )

app.get('/' , (req , res)=> {
    res.send('server is ready')
})

var clients = {} ;

io.on('connection', (socket) => {
    let sourceID = socket.handshake.query.sourceID ;
    console.log('a user connected');
     console.log( sourceID , 'is joined');
      socket.on( '/login' , (msg)=>{
        clients[sourceID] = socket ; 
        console.log(clients) ;
    })
    socket.on('/message', (msg)=>{
        let targetID = msg.targetID  ;
        app.get('/' , (req ,res)=>{
            res.send(msg);
        })
        console.log(msg);
        console.log(targetID) ; if (clients[targetID]) clients[targetID].emit("/receive" , msg)
        
    })
 
});

// app.get('/' , (req , res)=>{
//     res.send("<h1>Welcome Soufian to your Server Use Socket technologie</h1> <script src='/socket.io/socket.io.js'></script>'<script>var socket = io();</script>")
// })


// app.get('/chat' , (req,res)=>{
//     res.render('chat')
// })

// io.on('connection', (socket) => {
//     console.log('a user connected' , socket.handshake.query.username);
// //     // socket.on('chat message', (msg) => {
// //     //     console.log('message: ' + msg);
// //     //   });
// //   socket.join('room1', (msg) => {
// //     io.socket.in('room1').emit('chat message', msg);
// //   });
// });

// server.listen('3000' , (req , res)=>{
//     console.log('you are entre in http://127.0.0.1:3000/')
// })
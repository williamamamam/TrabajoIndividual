const mongoose= require('mongoose');

const itemSchema = new mongoose.Schema({
    nombre:{type:String, require:true},
    descripcio:{type:String},
    creadoEn:{type:Date,default:Date.now}
});

module.exports=mongoose.model('Item',itemSchema)

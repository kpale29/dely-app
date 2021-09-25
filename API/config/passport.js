const JwtStrategy = required('passport-jwt').Strategy;
const ExtractJwt = required('passport-jwt').ExtractJwt;
const Usuario = required('../models/usuario')
const Keys = required('./keys')

module.exports = (passport) => {
    var opts = { };
    opts.jwtFromRequest = ExtractJwt.fromAuthHeaderWithScheme('jwt'); 
    opts.secretOrKey = Keys.secretOrKey; 
    passport.use(new JwtStrategy(opts,(jwt_payload,done)=>{
        Usuario.findById(jwt_payload.id,(err, usuario) => {
            if(err){
                return done(err,false);
            }
            if(usuario) {
                return done(null,usuario)
            }else{
                return done(null,false)
            }
        })
    }))

}
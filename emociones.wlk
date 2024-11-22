object gestorDeEmociones
{
    var property limiteIntensidad = 25
    var property intensidadInicialDeFuria = 100 

    // 5.
    method cambiarLimiteIntensidad(nuevoValor) {limiteIntensidad = nuevoValor}
    method cambiarIntensidadInicialDeFuria(nuevoValor) {intensidadInicialDeFuria = nuevoValor}
}

class Causa 
{
    const property puedeLiberarse
    const property descripcion
}
const melancolia = new Causa(puedeLiberarse = false, descripcion = "Sentirse triste")

class Emocion
{
    var intensidad
    var property eventosExperimentados = 0
    method intensidad() = intensidad
    method puedeLiberarse() = self.tieneIntensidadElevada()
    method tieneIntensidadElevada() = self.intensidad() > gestorDeEmociones.limiteIntensidad()
    method liberarse(evento) {self.reducirIntensidad(evento.impacto())}
    
    method experimentarEvento(evento) 
    {
        if(self.puedeLiberarse())
        {
            self.liberarse(evento)
        }
        eventosExperimentados += 1
    }

    method calcularIntensidadReducida(cantidad) = intensidad - cantidad
    method reducirIntensidad(cantidad) {intensidad = self.calcularIntensidadReducida(cantidad)}
}

class Furia inherits Emocion(intensidad = gestorDeEmociones.intensidadInicialDeFuria())
{
    const palabrotas = []

    method aprenderPalabrota(palabrota) {palabrotas.add(palabrota)}
    method olvidarPalabrota(palabrota) {palabrotas.remove(palabrota)}

    override method puedeLiberarse() = super() and palabrotas.any({palabrota => palabrota.length() > 7})
    override method liberarse(evento)
    {
        super(evento)
        if(not palabrotas.isEmpty()) self.olvidarPalabrota(palabrotas.first()) // Evitar operacion ilegal
    }
} 

class Alegria inherits Emocion
{
    override method intensidad() = intensidad.abs() // Por si se inicializa en negativo
    override method calcularIntensidadReducida(cantidad) = super(cantidad).abs()
    override method puedeLiberarse() = super() and eventosExperimentados.even()
}

class Tristeza inherits Emocion
{
    var property causa = melancolia // Esta emocion no podrá ser liberada 
    override method puedeLiberarse() = super() and causa.puedeLiberarse()
    override method liberarse(evento) 
    {
        super(evento)
        causa = new Causa(puedeLiberarse = true, descripcion = evento.descripcion())
    }
}

// No se unifican ya que podrían tener comportamientos distintos en un futuro
class Desagrado inherits Emocion
{
    override method puedeLiberarse() = super() and eventosExperimentados > intensidad
}
class Temor inherits Emocion 
{
    override method puedeLiberarse() = super() and eventosExperimentados > intensidad
}

class Ansiedad inherits Emocion
{
    var property eventosReprimidos = 0
    override method experimentarEvento(evento) 
    {
        super(evento)
        eventosReprimidos += 1
    }
    override method liberarse(evento) 
    {
        super(evento)
        eventosReprimidos = 0
    }
    override method puedeLiberarse() = super() and eventosReprimidos > 2

    /*
        Utilización de Polimorfismo y Herencia:
            La clase Ansiedad utiliza la herencia para obtener
            los atributos y el comportamiento base (mensajes que entiende)
            de la clase Emocion.

            A su vez implementa comportamiento extra como el manejo de eventos reprimidos,
            los cuales afectan a su condicion para liberarse.
            
            Debido a que se utiliza herencia y especialmente override para reemplazar funcionalidades,
            la clase y sus instancias son polimórficas con las demás emociones,
            ya que entienden los mismos mensajes que envian los objetos con los que interactua.
            Por ejemplo el mensaje experimentarEvento.
    */

}

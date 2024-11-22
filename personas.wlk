class Persona
{
    var property edad
    const property emociones = []

    // 1.
    method esAdolescente() = edad.between(12, 19)
    method crecer() {edad += 1}

    // 2.
    method tenerNuevaEmocion(emocion) {emociones.add(emocion)}
    method perderEmocion(emocion) {emociones.remove(emocion)} // Extra

    // 3.
    method estaPorExplotarEmocionalmente() = emociones.all({emocion => emocion.puedeLiberarse()})

    // 4.
    method vivir(evento) {emociones.forEach({emocion => emocion.experimentarEvento(evento)})}

}

class Grupo
{
    const property integrantes = []

    method recibir(persona) {integrantes.add(persona)}  // Extra
    method quitar(persona) {integrantes.remove(persona)}  // Extra

    // 6.
    method vivir(evento) {integrantes.forEach({integrante => integrante.vivir(evento)})}
    method estaPorExplotarEmocionalmente() = integrantes.all({integrante => integrante.estaPorExplotarEmocionalmente()})
}
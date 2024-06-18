
/*
Alumno: Montes Fabián
Legajo: 143.754-9
*/


class Musico {
	var property instrumento
	var property estilos = []
	var property calidad = 0
	var property allegados = 0
	
	method cambiarInstrumento(nuevoInstrumento) {
		instrumento = nuevoInstrumento
	}
	
	method agregarEstilo(nuevoEstilo) {
		estilos.add(nuevoEstilo)
	}

	method calcularCalidad(){
		calidad = estilos.size() * 5 + instrumento.puntos()
	}
	
	method estaPegado() = allegados > 20000
}


class Banda{
	var property musicos = []
	var property estilos = []
	var property calidad = 0
	
	
	method agregarMusico(musico) {
		const nuevoIntegrante = self.nuevoIntegrante(musico)
		self.requisitosParaSerIntegrante(nuevoIntegrante)
		musicos.add(musico)
	}
	
	method requisitosParaSerIntegrante(nuevoIntegrante){
		if (nuevoIntegrante.any({ unMusico => unMusico.instrumento.esVocalista() })){
			throw new Exception("Ya hay un vocalista en la banda")
		}
		if (!musicos.any({ unMusico => unMusico.estilos.filter(musico.estilos.contains(estilos)).isEmpty() })){
			throw new Exception("El nuevo integrante no tiene estilos en comun con la banda")
		}
		if (musicos.size() >= 4){
			throw new Exception("La banda ya tiene 4 integrantes")
		}
	}
	
	method calidadBanda(){
		calidad = estilos.size() * 5 + musicos.max({unMusico => unMusico.calidad}).get() * musicos.size() * 2
	}
}



class Instrumento {
	method esVocalista() = false
	method puntos() = 0
}

class Guitarra inherits Instrumento{
	var property tipo
	var property cuerdasSanas = 6
	var property amplificador
	
	override method puntos() = tipo.puntos() + cuerdasSanas
}

class TipoDeGuitarra{
	method puntos() = 0
}

class Criolla inherits TipoDeGuitarra{
	override method puntos() = 10
}

class Electrica inherits TipoDeGuitarra{
	override method puntos() = 15
}


class Bajo inherits Instrumento{
	var property color = "negro"
	
	override method puntos() = if (musico.estilos == "metal") 5 || if (color == "rojo") 7 else 2
}


class Bateria inherits Instrumento{
	override method puntos() = 10 + if (musico.estilos =="rock") 10
}

class Voz inherits Instrumento {
	var property puntosFijos = 16
	
	override method esVocalista() = true
	override method puntos() = puntosFijos
}



class Recital {
	var property duracion
	var property participantes
	var property musico
	
	method ganarAllegados(){
		var allegados = musico.calidad() * participantes /100
		if (duracion < 1){
			allegados -= participantes * 0.03
		}
		allegados = Math.min(allegados, participantes)
		musico.allegados += allegados
		if(musico.kindof(Banda)){
			var musicoMasCalidad = musico.musicos.max({ unMusico => unMusico.calidad}).get()
			musicoMasCalidad.allegados += allegados / 2
		}
	}

}


object taylor inherits Musico(
	instrumento = new Voz(),
	estilos = ["pop","rock","country"],
	calidad = self,
	allegados = self){
}

object maikel inherits Musico(
	instrumento = new Voz(),
	estilos = ["pop","soul"]){
}

object riorio inherits Musico(
	instrumento = new Electrica(),
	estilos = ["metal","heavy metal"]){
}

object hellMusic inherits Musico(
	instrumento = new Voz(),
	estilos = ["metal","death metal"]){
}

object truquillo inherits Musico(
	instrumento = new Bajo(),
	estilos = ["rock", "metal"]){
}

object emiliaViernes inherits Musico(
	instrumento = new Voz(),
	estilos = ["cumbia uruguaya","voz"]){
}

object rengoEstar inherits Musico(
	instrumento = new Bateria(),
	estilos = ["rock","pop"],
	
	){
}







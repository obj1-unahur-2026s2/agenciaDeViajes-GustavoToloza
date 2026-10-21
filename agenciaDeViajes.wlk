class Pack {
    var dias
    var precioBase
    const beneficiosEspeciales = []
    var coordinador

    method dias() = dias
    method precioBase() = precioBase
    method beneficiosEspeciales() = beneficiosEspeciales
    method coordinador() = coordinador

    method agregarBeneficio(unBeneficio) {
      beneficiosEspeciales.add(unBeneficio)
    }
    method quitarBeneficio(unBeneficio) {
      beneficiosEspeciales.remove(unBeneficio)
    }

    method valorFinal() {
      return precioBase + self.costoDeBeneficios()
    }

    method beneficiosVigentes() {
      return beneficiosEspeciales.filter({b=>b.estaVigente()})
    }
    method costoDeBeneficios() {
       return self.beneficiosVigentes().sum(0,{b=>b.costo()})
    }

    method esPackPremium() {
      return 
    }

}

class PackNacionales inherits Pack{

    const provinciaDestino
    const actividades = []

    method provinciaDestino() = provinciaDestino
    method actividades() = actividades

    override method esPackPremium() {
      return dias > 10 and coordinador.esAltamenteCalificado()
    }

}

class PackProvinciales inherits PackNacionales{
    const cantCiudades

    method cantCiudades() {
      return cantCiudades
    } 

    override method esPackPremium() {
        return actividades.size() >= 4 and cantCiudades > 5 and self.beneficiosVigentes().size() >= 3
    }

    override method valorFinal() {
        return if(self.esPackPremium()) super()*1.05 else super()
    }
}

class PackInternacionales inherits Pack {
  
    const paisDestino 
    const cantEscalas
    var esDeInteres

    method paisDestino() = paisDestino
    method cantEscalas() = cantEscalas
    method esDeInteres() = esDeInteres

    override method valorFinal() {
      return super() * 1.20
    }

    override method esPackPremium() {
      return esDeInteres and dias > 20 and (cantEscalas == 0)
    }

}

class Coordinador {
    
    var rol 
    var cantViajes
    var estaMotivado
    var aniosExperiencia

    method rol() = rol
    method cantViajes() = cantViajes
    method estaMotivado() = estaMotivado
    method aniosExperiencia() = aniosExperiencia

    method cambiarRol(nuevoRol) {
        if(![guia,asistenteLogistico,acompaniante].contains(nuevoRol)){
            self.error("Rol inválido")
        }
            rol = nuevoRol
    }

    method esAltamenteCalificado() {
       return self.cantViajes() > 20 and self.cumple()
    }

    method cumple() {
      return rol.cumple(self)
    }

}

object guia {
    method cumple(unCoordinador) {
        return unCoordinador.estaMotivado()
    }
}
object asistenteLogistico {

    method cumple(unCoordinador) {
      return unCoordinador.aniosExperiencia() >= 3
    }
  
}
object acompaniante {
    method cumple(unCoordinador) {
      return true
    }
}

class Beneficios{

    const tipo // en string
    var estaVigente
    var costo

    method costo() = costo

    method tipo(){
        return tipo
    }
    method estaVigente() = estaVigente

}

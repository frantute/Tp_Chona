// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Colegio {

    // Variables Pedidas
    string private Nombre;
    string private Apellido;
    string private Curso;
    address private Profesor;
    mapping (string => uint8) private Notas_De_Las_Materias;
    string [] private Nom_Materias;
    // Constructor con sus variables
    constructor(string memory Nombre_, string memory Apellido_, string memory Curso_) {
        Nombre = Nombre;
        Apellido = Apellido;
        Curso = Curso;
        Profesor = msg.sender;
    }
    //devuelve el apellido del estudiante como string.
    function apellido() public view returns (string memory) {
        return Apellido;
    }
    //Llama a la funcion AppendString, que toma el nombre y el apellido, los junta y devuelve el resultado como string
    function nombre_completo() public view returns (string memory) {
        return AppendString(Nombre, " ", Apellido);
    }
    //devuelve el curso del alumno como string.
    function curso() public view returns (string memory) {
        return Curso;
    }
    //(T nota, string memory materia) asigna el valor notas_materias a nota donde la key es la materia. La nota se recibe como un entero del 1 al 100. Atención, solo el docente registrado puede llamar a esta función.
    function Set_Nota_Materia(uint8 _Nota, string memory _Materia) public {
        require(Profesor == msg.sender, "No es posible cambiar la nota");
        require(_Nota <= 100 && _Nota >= 1, "La nota ingresada no es valida");
        Notas_De_Las_Materias[_Materia] = _Nota;
        Nom_Materias.push(_Materia);
    }
    //(string memory materia) devuelve la nota del Estudiante dada una materia.
    function Nota_Materia(string memory _Materia) public view returns (uint) {
        uint _Nota = Notas_De_Las_Materias[_Materia];   
        return _Nota;
    }
    //(string memory materia) devuelve True si solo si el alumno está aprobado en la materia. La materia se aprueba con 6/10 o más.
    function Aprobo(string memory _Materia) public view returns (bool) {
        require (Notas_De_Las_Materias[_Materia] >= 60);
        return true; 
    }
    //Toma la cantidad de items en el mapping, suma todas las notas y las divide por la cantidad de items y devuelve un entero con el promedio del alumno.
    function promedio() public view returns (uint) {
        uint _CantItems = Nom_Materias.length;
        uint _NotaParaPromedio;
        uint _NotaFinal;
        for (uint i = 0; i < _CantItems; i++){
            _NotaParaPromedio += Notas_De_Las_Materias[Nom_Materias[i]];
        }
        _NotaFinal = _NotaParaPromedio / _CantItems;
        return _NotaFinal;
    }
    //Junta lo que le pases, idealmente a y c son el nombre y el apellido respectivamente, b es un espacio. Devuelve el nombre y el apellido juntos como string
    function AppendString(string memory a, string memory b, string memory c) public pure returns (string memory) {
        return string(abi.encodePacked(a,b,c));
    }
}

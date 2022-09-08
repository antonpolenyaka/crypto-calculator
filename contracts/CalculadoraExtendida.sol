/************************************************************
 * 
 * Autor: Anton Polenyaka
 *
 * 446576656c6f7065723a20416e746f6e20506f6c656e79616b61 ****/

// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract CalculatorExtended {
    // Attributies
    mapping(address => int256) private _walletToMemory;

    // Events
    event DivisionPorCero(address wallet, int256 valueA);

    // Constructors
    constructor()
    {
        setMemory(0);
    }

    // Private internal functions
    function getMemory() internal view returns(int256) {
        return _walletToMemory[msg.sender];
    }

    function setMemory(int256 value) internal {
        _walletToMemory[msg.sender] = value;
    }

    // Functions
    function suma(int256 a, int256 b) public pure returns (int256)
    {
        return a + b;
    }
    
    function sumaMemoria(int256 a) public view returns (int256)
    {
        return a + getMemory();
    }

    function resta(int256 a, int256 b) public pure returns (int256)
    {
        return a - b;
    }

    function restaMemoria(int256 a) public view returns (int256)
    {
        return a - getMemory();
    }

    function almacenaMemoria(int256 resultado) public returns (int256)
    {
        setMemory(resultado);
        return resultado;
    }

    function obtenerMemoria() public view returns (int256)
    {
        return getMemory();
    }

    function borrarMemoria() public
    {
        setMemory(0);
    }

    // New functions

    // Devuelve el producto de a y b.
    function multiplica(int256 a, int256 b) public pure returns (int256) {
        return a * b;
    }

    // Devuelve el cociente de dividir a y b. En caso de que b sea 0, debe devolver un error con assert/require.
    function divide(int256 a, int256 b) public pure returns (int256) {
        require(b != 0, "ERROR: value b need to be different 0");
        return a / b;
    }

    // Devuelve el producto de a y el valor almacenado en memoria.
    function multiplicaMemoria(int256 a) public view returns (int256) {
        return a * getMemory();
    }

    // Devuelve el cociente de dividir a entre el valor almacenado en memoria. En caso de que el valor de memoria sea 0, debe generar un evento DivisionPorCero indicando el identificador de usuario y el valor de a.
    function divideMemoria(int256 a) public returns (int256 result) {
        int256 valMemory = getMemory();
        if(valMemory == 0) {
            emit DivisionPorCero(msg.sender, a);
        } else {
            result = a / getMemory();
        }        
    }

    // Devuelve el valor factorial de a. En caso de que el valor de a sea negativo, debe devolver un error con assert/require.
    // A max 57, greater that number we get EVM error
    function factorial(int256 a) public pure returns (int256 result) {
        require(a >= 0, "ERROR: value a need to be greater of 0");
        // Teniendo en cuenta definición de función factorial podemos ver que no tiene sentido aplicarla en el caso del “0”. 
        // No existen números positivos anteriores al 0 por lo que 0 x 0 = 0.
        // No obstante, se ha acordado que en el caso de 0 factorial el resultado será igual a 1:
        // 0! = 0 x 0 = 1
        if(a == 0) {
            result = 1;
        } else {
            result = a;
            for(a = a - 1;a > 0; a--) {
                result *= a;
            }
        }
    }
}
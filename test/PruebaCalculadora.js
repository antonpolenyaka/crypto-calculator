const Calculadora = artifacts.require("./Calculadora.sol");

contract("Calculadora", accounts => {
	var calc;
	
	beforeEach("Crear nueva calculadora", async function() {
        calc = await Calculadora.deployed();
	});
	
	afterEach("Borrar memoria", async function() {
        await calc.borrarMemoria();
	});
	
	it("Comprobar Memoria", async () => {
		await calc.almacenaMemoria(23);
		assert.equal(await calc.obtenerMemoria(), 23);
	});
	
	it("Comprobar operaciones algebraicas", async () => {
		assert.equal(await calc.suma(20, 7), 27);
		assert.equal(await calc.resta(27, 4), 23);
	});
	
	it("Comprobar operaciones algebraicas con memoria", async () => {
		await calc.almacenaMemoria(2);
		assert.equal(await calc.sumaMemoria(5), 7);
		assert.equal(await calc.restaMemoria(2), 0);
	});
});
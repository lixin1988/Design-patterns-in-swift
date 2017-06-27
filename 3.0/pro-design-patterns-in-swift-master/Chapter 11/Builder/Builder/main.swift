// Step 1 - Ask for name
let name = "Joe";

// Step 2 - Select a Product
let builder = BurgerBuilder.getBuilder(Burgers.bigburger);

// Step 3 - Customize burger?
builder.setMayo(false);
builder.setCooked(Burger.Cooked.WELLDONE);

let order = builder.buildObject(name);

order.printDescription();

% PHP Cheatshet
% &copy;D.Sánchez
% 2024

\pagebreak

# PHP Cheatsheet ( OOP included )

## Defining Classes:

```php
class ClassName extends Baseclass {
/* Class named ClassName, implementing all functions BaseClass delivers, being able to override it's functions, or not.*/

public $myPublicProperty;
/* Dynamic, public property accesible from outside the class as well as within a class instance.*/

protected $myProtectedProperty;
/* Dynamic, protected property only accesible from within a class' instance, it's baseclass and it's subclasses.*/

private	$myPrivateProperty;
/* Dynamic private property, only accessible from the class instance itself. */
public function __construct( $tmpVariable ) {
/* Dynamic public function, callable from any class instance operating on the instance only. This function is executed automatically every time the class is instantiated. */
	self::$myStaticFunction();
/* Call a static funcion that is callable from the class itself. */
	$this->myPrivateFunction( $tmpVariable );
/* Call a dynamic function providing data through a variable to it.*/
	$this->myPrivateProperty = 'Hello World!';
/* Assign data to a dynamic property of a class instance.*/
}

static function myStaticFunction() {
/* Static function that is callable upon the class istself. */
}

private function myPrivateFunction( $tmpVariable ) {
/* Private function that is only callable from within a class instance. Please take into account that the variable $tmpVariable, despite having the same name as the variable in the class constructor, is different and can hold a different set of data. See Variable Scope */
}

public function __destruct() {
/* This funcion is called upon destruction i.e. the deletion of the object from memory.*/
}

}
```

## Magic Methods

```php
function __construct() {
/* The class constructor is executed upon instantiating a class. It allows to initialize the class members as well as internat error checckin.*/
}

function __destruct() {
/* The class destructor is executed whenever an instance is deleted from memory. It allow cleaning up memory before vanishing and thus prevents memory leaks.*/
}

function __toString() {
/* This function is executed whenever the class instance is used in a  context where it has to act as a string. This can be used to describe the actual class.*/
}
```

## Using Classes:

```php
	$myClassInstance = new ClassName( $tmpVariable );
/* Instantiates a class (with a variable) */

	$myClassInstance->myPrivateFunction();
/* Calls a dynamic method from the class (in this example, it will throw an error as the method we are calling is private)*/

	ClassName::myStaticFunction();
/* Calls a static method (function) from the class. Note that there is no need to instantiate the class first! */	
```

## Flow Control

```php
// if...then...else:
if (condition) {
	//CODE BLOCK
} else {
	//CODE BLOCK
}

// for loop:
for ( $counter = 1; $counter < 100; $counter++ ){
/* First, initialize the variable, then establish the stop condition and lastly define the counter behavior. */
	//CODE BLOCK
}

// foreach iteration:
foreach ($tmpArray as $key=>$value) {
/* Iterate over all items of an array providing each loop with the associated key value pair. */
	//CODE BLOCK
}

// while loop:
while (condition) {
/* Check a condition, and if while it's true, loop through the code block. */
	//CODE BLOCK
}

// do...while loop:
do {
/* Similar to while loop, whereas in this case, the condition is evaluated at the end of the loop i.e. the loop is executed at least one time. */
	//CODE BLOCK
} while (condition)

//switch statement:
switch ($myVariable) {
/* This command acts as a concatenated if chain where $myVariable is to be evaluated. */
case VALUE:
/* In case $myVariable holds VALUE, execute code block... */
	//CODE BLOCK
	break;
/* The break keyword is not mandatory. If it's not provided, the code execution 'falls through' to the next block. */
case ANOTHER VALUE:
	//CODE BLOCK
	break;
default:
	//CODE BLOCK
}

//Ternary Operator:
(condition)?(true):(false);
/* Example: $myVariable = ($myFlagSet)? 'Flag':'No Flag'; */
```

## Operators

### Arithmetical Operators:
`a+b`	Sum
`a-b`	Difference
`a*b`	Multiplication
`a/b`	Division ( with floating point result )
`a%b`	Modulus
`a**b`	a to the power of b

### Incremental Operators:
`++a`	Pre Increment
`a++`	Post Increment
`--b`	Pre Decrement
`b--`	Post Decrement

### Bitwise Operators:
`a&b`	Bitwise AND
`a|b`	Bitwise OR
`a^b`	Bitwise XOR
`~a`	Bitwise NOT
`a<<b`	Bitwise SHL
`a>>b`	Bitwise SHR

### Logical Operators:
`a&&b`
`a and b` 	Logical AND 
`a||b`
`a or b` 	Logical OR
`a xor b`	Logical XOR
`!a`		Logical NOT

### Comparison Operators:
`a == b`	Equal
`a <> b`	Not Equal
`a != b`	Not Equal
`a === b`	Identical
`a !== b`	Not Identical
`a < b`		Less than
`a <= b`	Less or equal
`a > b`		Greater than
`a >= b`	Greater or equal



## Using and defining Arrays:
### Simple Array:

`$myArray = array( 1, 2, 3, 4, 5 );`

### Shorthand method:

`$myArray = [ 1, 2, 3, 4, 5 ];`

### Append Data:

`$myArray[] = 6;`

### Delete Element:

`unset( $myArray[6] );`

### Associative Array:

`$myArray = array( “index1”=>”value1”, “index2”=>”value2” );`

### Shorthand Method:

`$myArray = [ “index1”=>”value1”, “index2”=>”value2” ];`



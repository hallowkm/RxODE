//loop

statement_list : (statement)+ ;

statement 
  : ini end_statement 
  | ini0 end_statement
  | assignment end_statement
  | derivative end_statement
  | jac end_statement
  | dfdy end_statement
  | compound_statement
  | selection_statement
  | printf_statement end_statement
  | print_command end_statement
  | end_statement ;


compound_statement : '{' statement_list? '}' ;

selection_statement
  : 'if' '(' logical_or_expression ')' statement ('else' statement)?;

printf_statement
  : printf_command '(' string (',' additive_expression )* ')';

printf_command
  : 'printf'      | 'Rprintf'      | 'print'      |
    'jac_printf'  | 'jac_Rprintf'  | 'jac_print'  |
    'ode_printf'  | 'ode_Rprintf'  | 'ode_print'  |
    'jac0_printf' | 'jac0_Rprintf' | 'jac0_print' |
    'ode_printf'  | 'ode_Rprintf'  | 'ode_print'  |
    'ode0_printf' | 'ode0_Rprintf' | 'ode0_print' |
    'lhs_printf'  | 'lhs_Rprintf'  | 'lhs_print'  ;

print_command
  : 'print' | 'ode_print' | 'jac_print' | 'lhs_print';

ini0       : identifier ('(0)' | '{0}' | '[0]') ('=' | '<-') ini_const;

ini        : identifier ('=' | '<-') ini_const;

derivative : 'd/dt' '(' identifier_no_output ')' ('=' | '<-') additive_expression;
der_rhs    : 'd/dt' '(' identifier_no_output ')';
jac        : jac_command '(' identifier_no_output ',' identifier_no_output ')' ('=' | '<-') additive_expression;
jac_rhs    : jac_command '(' identifier_no_output ',' identifier_no_output ')';

dfdy        : 'df' '(' identifier_no_output ')/dy(' identifier_no_output ')' ('=' | '<-') additive_expression;
dfdy_rhs    : 'df' '(' identifier_no_output ')/dy(' identifier_no_output ')';

jac_command : 'jac' | 'df/dy';

end_statement : (';')* ;

assignment : identifier ('=' | '<-') additive_expression;

logical_or_expression :	logical_and_expression 
    (('||' | '|')  logical_and_expression)* ;

logical_and_expression : equality_expression 
    (('&&' | '&') equality_expression)* ;

equality_expression : relational_expression 
  (('!=' | '~=' | '<>' | '/=' | '==') relational_expression)* ;

relational_expression : additive_expression
 (('<' | '>' | '<=' | '>=') additive_expression)* ;

additive_expression : multiplicative_expression
  (('+' | '-') multiplicative_expression)* ;

multiplicative_expression : unary_expression 
  (('*' | '/') unary_expression)* ;

unary_expression : ('+' | '-')? (primary_expression | power_expression);

power_expression : primary_expression power_operator primary_expression ;

power_operator   : ('^' | '**');

primary_expression 
  : identifier
  | der_rhs
  | jac_rhs
  | dfdy_rhs
  | constant
  | function
  | '(' additive_expression ')';

function : identifier '(' additive_expression (',' additive_expression)* ')' ;

ini_const : '-'? constant;

constant : decimalint | float1 | float2;


decimalint: "0|([1-9][0-9]*)" $term -1;
string: "\"([^\"\\]|\\[^])*\"";
float1: "([0-9]+.[0-9]*|[0-9]*.[0-9]+)([eE][\-\+]?[0-9]+)?" $term -2;
float2: "[0-9]+[eE][\-\+]?[0-9]+" $term -3;
identifier: "[a-zA-Z_][a-zA-Z0-9_]*" $term -4;
identifier_no_output: "[a-zA-Z_][a-zA-Z0-9_]*" $term -4;
whitespace: ( "[ \t\r\n]+" | singleLineComment )*;
singleLineComment: '#' "[^\n]*" '\n';

typedef enum { typeCon, typeId, typeOpr } nodeEnum;

/* Constants Node Type */
typedef struct {
    int value;  /* Value of the constant */
} conNodeType;

/* Identifiers Node Type */
typedef struct {
    int i;  /* Index in the symbol table */
} idNodeType;

/* Operators Node Type */
typedef struct {
    int oper;  /* Operator */
    int nops;  /* Number of operands */
    struct nodeTypeTag *op[1];  /* Operands, extended at runtime */
} oprNodeType;

/* General Node Type */
typedef struct nodeTypeTag {
    nodeEnum type;  /* Type of node: constant, identifier, or operator */

    union {
        conNodeType con;  /* Constant node */
        idNodeType id;    /* Identifier node */
        oprNodeType opr;  /* Operator node */
    };
} nodeType;

/* Symbol Table */
extern int sym[26];  /* Array to store values of variables 'a' to 'z' */



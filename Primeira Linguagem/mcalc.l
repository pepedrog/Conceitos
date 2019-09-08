D [0-9]
E [Ee][+-]?{D}+ 

%{
#include <math.h>
#include "mcalc.tab.h"

%}


%%
{D}*[.]?{D}+{E}?	{ yylval.val = yytext; return NUM; }

[ \t\n]+	/* pula espacos em branco */

#.*		/* comentarios simples */

[(]		{ return OPEN; }
[)]		{ return CLOSE; }
[+]		{ return ADD; }
[-]		{ return SUB; }
[*]		{ return MUL; }
[/]		{ return DIV; }
\w      { printf("aqui\n");yylval.val = yytext; return FUNC; }
(fatorial)       { printf("aquii = %s\n", yytext);yylval.val = yytext; return FUNC; }


%%

/* Local Variables: */
/* mode: c */
/* End: */

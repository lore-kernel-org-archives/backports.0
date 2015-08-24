Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:59902 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932773AbbHXJQa (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 24 Aug 2015 05:16:30 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: update Kconfig tools from upstream
Date: Mon, 24 Aug 2015 11:16:25 +0200
Message-Id: <1440407785-9458-1-git-send-email-johannes@sipsolutions.net> (sfid-20150824_111641_245862_AA2FDBCB)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/Kconfig                   |    9 +
 backport/kconf/conf.c                     |   26 +-
 backport/kconf/confdata.c                 |  114 +++-
 backport/kconf/expr.c                     |  288 ++++----
 backport/kconf/expr.h                     |   17 +-
 backport/kconf/list.h                     |   44 +-
 backport/kconf/lkc.h                      |   18 +-
 backport/kconf/lkc_proto.h                |   84 ++-
 backport/kconf/lxdialog/check-lxdialog.sh |   12 +-
 backport/kconf/lxdialog/checklist.c       |   12 +-
 backport/kconf/lxdialog/dialog.h          |   25 +-
 backport/kconf/lxdialog/inputbox.c        |   10 +-
 backport/kconf/lxdialog/menubox.c         |   19 +-
 backport/kconf/lxdialog/textbox.c         |    6 +-
 backport/kconf/lxdialog/util.c            |   87 ++-
 backport/kconf/lxdialog/yesno.c           |    8 +-
 backport/kconf/mconf.c                    |  202 ++++--
 backport/kconf/menu.c                     |   99 ++-
 backport/kconf/symbol.c                   |  151 +++--
 backport/kconf/util.c                     |   12 -
 backport/kconf/zconf.hash.c               |   13 +-
 backport/kconf/zconf.lex.c                |  318 +++++----
 backport/kconf/zconf.tab.c                | 1014 ++++++++++++++++-------------
 23 files changed, 1583 insertions(+), 1005 deletions(-)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index b5bf348957c9..ed600a3e53bb 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -53,6 +53,15 @@
 # Variations are obviously possible.
 #
 
+config BP_MODULES
+	option modules
+	bool
+	default MODULES
+
+	help
+	This symbol is necessary for the newer kconf tool, it looks
+	for the "option modules" to control the 'm' state.
+
 config BPAUTO_BUILD_CORDIC
 	tristate
 	depends on !CORDIC
diff --git a/backport/kconf/conf.c b/backport/kconf/conf.c
index e39fcd8143ea..6c204318bc94 100644
--- a/backport/kconf/conf.c
+++ b/backport/kconf/conf.c
@@ -13,6 +13,7 @@
 #include <getopt.h>
 #include <sys/stat.h>
 #include <sys/time.h>
+#include <errno.h>
 
 #include "lkc.h"
 
@@ -470,7 +471,7 @@ static struct option long_opts[] = {
 static void conf_usage(const char *progname)
 {
 
-	printf("Usage: %s [option] <kconfig-file>\n", progname);
+	printf("Usage: %s [-s] [option] <kconfig-file>\n", progname);
 	printf("[option] is _one_ of the following:\n");
 	printf("  --listnewconfig         List new options\n");
 	printf("  --oldaskconfig          Start a new configuration using a line-oriented program\n");
@@ -500,7 +501,11 @@ int main(int ac, char **av)
 
 	tty_stdio = isatty(0) && isatty(1) && isatty(2);
 
-	while ((opt = getopt_long(ac, av, "", long_opts, NULL)) != -1) {
+	while ((opt = getopt_long(ac, av, "s", long_opts, NULL)) != -1) {
+		if (opt == 's') {
+			conf_set_message_callback(NULL);
+			continue;
+		}
 		input_mode = (enum input_mode)opt;
 		switch (opt) {
 		case silentoldconfig:
@@ -514,14 +519,24 @@ int main(int ac, char **av)
 		{
 			struct timeval now;
 			unsigned int seed;
+			char *seed_env;
 
 			/*
 			 * Use microseconds derived seed,
 			 * compensate for systems where it may be zero
 			 */
 			gettimeofday(&now, NULL);
-
 			seed = (unsigned int)((now.tv_sec + 1) * (now.tv_usec + 1));
+
+			seed_env = getenv("KCONFIG_SEED");
+			if( seed_env && *seed_env ) {
+				char *endp;
+				int tmp = (int)strtol(seed_env, &endp, 0);
+				if (*endp == '\0') {
+					seed = tmp;
+				}
+			}
+			fprintf( stderr, "KCONFIG_SEED=0x%X\n", seed );
 			srand(seed);
 			break;
 		}
@@ -643,7 +658,8 @@ int main(int ac, char **av)
 		conf_set_all_new_symbols(def_default);
 		break;
 	case randconfig:
-		conf_set_all_new_symbols(def_random);
+		/* Really nothing to do in this loop */
+		while (conf_set_all_new_symbols(def_random)) ;
 		break;
 	case defconfig:
 		conf_set_all_new_symbols(def_default);
@@ -684,7 +700,7 @@ int main(int ac, char **av)
 	} else if (input_mode == savedefconfig) {
 		if (conf_write_defconfig(defconfig_file)) {
 			fprintf(stderr, _("n*** Error while saving defconfig to: %s\n\n"),
-			        defconfig_file);
+				defconfig_file);
 			return 1;
 		}
 	} else if (input_mode != listnewconfig) {
diff --git a/backport/kconf/confdata.c b/backport/kconf/confdata.c
index 13ddf1126c2a..c814f57672fc 100644
--- a/backport/kconf/confdata.c
+++ b/backport/kconf/confdata.c
@@ -16,6 +16,11 @@
 
 #include "lkc.h"
 
+struct conf_printer {
+	void (*print_symbol)(FILE *, struct symbol *, const char *, void *);
+	void (*print_comment)(FILE *, const char *, void *);
+};
+
 static void conf_warning(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 
@@ -59,6 +64,7 @@ static void conf_message(const char *fmt, ...)
 	va_start(ap, fmt);
 	if (conf_message_callback)
 		conf_message_callback(fmt, ap);
+	va_end(ap);
 }
 
 const char *conf_get_configname(void)
@@ -140,7 +146,9 @@ static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
 			sym->flags |= def_flags;
 			break;
 		}
-		conf_warning("symbol value '%s' invalid for %s", p, sym->name);
+		if (def != S_DEF_AUTO)
+			conf_warning("symbol value '%s' invalid for %s",
+				     p, sym->name);
 		return 1;
 	case S_OTHER:
 		if (*p != '"') {
@@ -161,7 +169,8 @@ static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
 			memmove(p2, p2 + 1, strlen(p2));
 		}
 		if (!p2) {
-			conf_warning("invalid string found");
+			if (def != S_DEF_AUTO)
+				conf_warning("invalid string found");
 			return 1;
 		}
 		/* fall through */
@@ -172,7 +181,9 @@ static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
 			sym->def[def].val = strdup(p);
 			sym->flags |= def_flags;
 		} else {
-			conf_warning("symbol value '%s' invalid for %s", p, sym->name);
+			if (def != S_DEF_AUTO)
+				conf_warning("symbol value '%s' invalid for %s",
+					     p, sym->name);
 			return 1;
 		}
 		break;
@@ -1040,7 +1051,7 @@ void conf_set_changed_callback(void (*fn)(void))
 	conf_changed_callback = fn;
 }
 
-static void randomize_choice_values(struct symbol *csym)
+static bool randomize_choice_values(struct symbol *csym)
 {
 	struct property *prop;
 	struct symbol *sym;
@@ -1053,7 +1064,7 @@ static void randomize_choice_values(struct symbol *csym)
 	 * In both cases stop.
 	 */
 	if (csym->curr.tri != yes)
-		return;
+		return false;
 
 	prop = sym_get_choice_prop(csym);
 
@@ -1077,13 +1088,18 @@ static void randomize_choice_values(struct symbol *csym)
 		else {
 			sym->def[S_DEF_USER].tri = no;
 		}
+		sym->flags |= SYMBOL_DEF_USER;
+		/* clear VALID to get value calculated */
+		sym->flags &= ~SYMBOL_VALID;
 	}
 	csym->flags |= SYMBOL_DEF_USER;
 	/* clear VALID to get value calculated */
 	csym->flags &= ~(SYMBOL_VALID);
+
+	return true;
 }
 
-static void set_all_choice_values(struct symbol *csym)
+void set_all_choice_values(struct symbol *csym)
 {
 	struct property *prop;
 	struct symbol *sym;
@@ -1100,20 +1116,66 @@ static void set_all_choice_values(struct symbol *csym)
 	}
 	csym->flags |= SYMBOL_DEF_USER;
 	/* clear VALID to get value calculated */
-	csym->flags &= ~(SYMBOL_VALID);
+	csym->flags &= ~(SYMBOL_VALID | SYMBOL_NEED_SET_CHOICE_VALUES);
 }
 
-void conf_set_all_new_symbols(enum conf_def_mode mode)
+bool conf_set_all_new_symbols(enum conf_def_mode mode)
 {
 	struct symbol *sym, *csym;
-	int i, cnt;
+	int i, cnt, pby, pty, ptm;	/* pby: probability of boolean  = y
+					 * pty: probability of tristate = y
+					 * ptm: probability of tristate = m
+					 */
+
+	pby = 50; pty = ptm = 33; /* can't go as the default in switch-case
+				   * below, otherwise gcc whines about
+				   * -Wmaybe-uninitialized */
+	if (mode == def_random) {
+		int n, p[3];
+		char *env = getenv("KCONFIG_PROBABILITY");
+		n = 0;
+		while( env && *env ) {
+			char *endp;
+			int tmp = strtol( env, &endp, 10 );
+			if( tmp >= 0 && tmp <= 100 ) {
+				p[n++] = tmp;
+			} else {
+				errno = ERANGE;
+				perror( "KCONFIG_PROBABILITY" );
+				exit( 1 );
+			}
+			env = (*endp == ':') ? endp+1 : endp;
+			if( n >=3 ) {
+				break;
+			}
+		}
+		switch( n ) {
+		case 1:
+			pby = p[0]; ptm = pby/2; pty = pby-ptm;
+			break;
+		case 2:
+			pty = p[0]; ptm = p[1]; pby = pty + ptm;
+			break;
+		case 3:
+			pby = p[0]; pty = p[1]; ptm = p[2];
+			break;
+		}
+
+		if( pty+ptm > 100 ) {
+			errno = ERANGE;
+			perror( "KCONFIG_PROBABILITY" );
+			exit( 1 );
+		}
+	}
+	bool has_changed = false;
 
 	for_all_symbols(i, sym) {
-		if (sym_has_value(sym))
+		if (sym_has_value(sym) || (sym->flags & SYMBOL_VALID))
 			continue;
 		switch (sym_get_type(sym)) {
 		case S_BOOLEAN:
 		case S_TRISTATE:
+			has_changed = true;
 			switch (mode) {
 			case def_yes:
 				sym->def[S_DEF_USER].tri = yes;
@@ -1122,11 +1184,21 @@ void conf_set_all_new_symbols(enum conf_def_mode mode)
 				sym->def[S_DEF_USER].tri = mod;
 				break;
 			case def_no:
-				sym->def[S_DEF_USER].tri = no;
+				if (sym->flags & SYMBOL_ALLNOCONFIG_Y)
+					sym->def[S_DEF_USER].tri = yes;
+				else
+					sym->def[S_DEF_USER].tri = no;
 				break;
 			case def_random:
-				cnt = sym_get_type(sym) == S_TRISTATE ? 3 : 2;
-				sym->def[S_DEF_USER].tri = (tristate)(rand() % cnt);
+				sym->def[S_DEF_USER].tri = no;
+				cnt = rand() % 100;
+				if (sym->type == S_TRISTATE) {
+					if (cnt < pty)
+						sym->def[S_DEF_USER].tri = yes;
+					else if (cnt < (pty+ptm))
+						sym->def[S_DEF_USER].tri = mod;
+				} else if (cnt < pby)
+					sym->def[S_DEF_USER].tri = yes;
 				break;
 			default:
 				continue;
@@ -1151,14 +1223,26 @@ void conf_set_all_new_symbols(enum conf_def_mode mode)
 	 * selected in a choice block and we set it to yes,
 	 * and the rest to no.
 	 */
+	if (mode != def_random) {
+		for_all_symbols(i, csym) {
+			if ((sym_is_choice(csym) && !sym_has_value(csym)) ||
+			    sym_is_choice_value(csym))
+				csym->flags |= SYMBOL_NEED_SET_CHOICE_VALUES;
+		}
+	}
+
 	for_all_symbols(i, csym) {
 		if (sym_has_value(csym) || !sym_is_choice(csym))
 			continue;
 
 		sym_calc_value(csym);
 		if (mode == def_random)
-			randomize_choice_values(csym);
-		else
+			has_changed = randomize_choice_values(csym);
+		else {
 			set_all_choice_values(csym);
+			has_changed = true;
+		}
 	}
+
+	return has_changed;
 }
diff --git a/backport/kconf/expr.c b/backport/kconf/expr.c
index d6626521f9b9..667d1aa23711 100644
--- a/backport/kconf/expr.c
+++ b/backport/kconf/expr.c
@@ -11,6 +11,9 @@
 
 #define DEBUG_EXPR	0
 
+static int expr_eq(struct expr *e1, struct expr *e2);
+static struct expr *expr_eliminate_yn(struct expr *e);
+
 struct expr *expr_alloc_symbol(struct symbol *sym)
 {
 	struct expr *e = xcalloc(1, sizeof(*e));
@@ -76,6 +79,10 @@ struct expr *expr_copy(const struct expr *org)
 		e->left.expr = expr_copy(org->left.expr);
 		break;
 	case E_EQUAL:
+	case E_GEQ:
+	case E_GTH:
+	case E_LEQ:
+	case E_LTH:
 	case E_UNEQUAL:
 		e->left.sym = org->left.sym;
 		e->right.sym = org->right.sym;
@@ -108,6 +115,10 @@ void expr_free(struct expr *e)
 		expr_free(e->left.expr);
 		return;
 	case E_EQUAL:
+	case E_GEQ:
+	case E_GTH:
+	case E_LEQ:
+	case E_LTH:
 	case E_UNEQUAL:
 		break;
 	case E_OR:
@@ -186,7 +197,7 @@ void expr_eliminate_eq(struct expr **ep1, struct expr **ep2)
 #undef e1
 #undef e2
 
-int expr_eq(struct expr *e1, struct expr *e2)
+static int expr_eq(struct expr *e1, struct expr *e2)
 {
 	int res, old_count;
 
@@ -194,6 +205,10 @@ int expr_eq(struct expr *e1, struct expr *e2)
 		return 0;
 	switch (e1->type) {
 	case E_EQUAL:
+	case E_GEQ:
+	case E_GTH:
+	case E_LEQ:
+	case E_LTH:
 	case E_UNEQUAL:
 		return e1->left.sym == e2->left.sym && e1->right.sym == e2->right.sym;
 	case E_SYMBOL:
@@ -228,7 +243,7 @@ int expr_eq(struct expr *e1, struct expr *e2)
 	return 0;
 }
 
-struct expr *expr_eliminate_yn(struct expr *e)
+static struct expr *expr_eliminate_yn(struct expr *e)
 {
 	struct expr *tmp;
 
@@ -553,62 +568,6 @@ static void expr_eliminate_dups1(enum expr_type type, struct expr **ep1, struct
 #undef e2
 }
 
-static void expr_eliminate_dups2(enum expr_type type, struct expr **ep1, struct expr **ep2)
-{
-#define e1 (*ep1)
-#define e2 (*ep2)
-	struct expr *tmp, *tmp1, *tmp2;
-
-	if (e1->type == type) {
-		expr_eliminate_dups2(type, &e1->left.expr, &e2);
-		expr_eliminate_dups2(type, &e1->right.expr, &e2);
-		return;
-	}
-	if (e2->type == type) {
-		expr_eliminate_dups2(type, &e1, &e2->left.expr);
-		expr_eliminate_dups2(type, &e1, &e2->right.expr);
-	}
-	if (e1 == e2)
-		return;
-
-	switch (e1->type) {
-	case E_OR:
-		expr_eliminate_dups2(e1->type, &e1, &e1);
-		// (FOO || BAR) && (!FOO && !BAR) -> n
-		tmp1 = expr_transform(expr_alloc_one(E_NOT, expr_copy(e1)));
-		tmp2 = expr_copy(e2);
-		tmp = expr_extract_eq_and(&tmp1, &tmp2);
-		if (expr_is_yes(tmp1)) {
-			expr_free(e1);
-			e1 = expr_alloc_symbol(&symbol_no);
-			trans_count++;
-		}
-		expr_free(tmp2);
-		expr_free(tmp1);
-		expr_free(tmp);
-		break;
-	case E_AND:
-		expr_eliminate_dups2(e1->type, &e1, &e1);
-		// (FOO && BAR) || (!FOO || !BAR) -> y
-		tmp1 = expr_transform(expr_alloc_one(E_NOT, expr_copy(e1)));
-		tmp2 = expr_copy(e2);
-		tmp = expr_extract_eq_or(&tmp1, &tmp2);
-		if (expr_is_no(tmp1)) {
-			expr_free(e1);
-			e1 = expr_alloc_symbol(&symbol_yes);
-			trans_count++;
-		}
-		expr_free(tmp2);
-		expr_free(tmp1);
-		expr_free(tmp);
-		break;
-	default:
-		;
-	}
-#undef e1
-#undef e2
-}
-
 struct expr *expr_eliminate_dups(struct expr *e)
 {
 	int oldcount;
@@ -621,7 +580,6 @@ struct expr *expr_eliminate_dups(struct expr *e)
 		switch (e->type) {
 		case E_OR: case E_AND:
 			expr_eliminate_dups1(e->type, &e, &e);
-			expr_eliminate_dups2(e->type, &e, &e);
 		default:
 			;
 		}
@@ -641,6 +599,10 @@ struct expr *expr_transform(struct expr *e)
 		return NULL;
 	switch (e->type) {
 	case E_EQUAL:
+	case E_GEQ:
+	case E_GTH:
+	case E_LEQ:
+	case E_LTH:
 	case E_UNEQUAL:
 	case E_SYMBOL:
 	case E_LIST:
@@ -713,6 +675,22 @@ struct expr *expr_transform(struct expr *e)
 			e = tmp;
 			e->type = e->type == E_EQUAL ? E_UNEQUAL : E_EQUAL;
 			break;
+		case E_LEQ:
+		case E_GEQ:
+			// !a<='x' -> a>'x'
+			tmp = e->left.expr;
+			free(e);
+			e = tmp;
+			e->type = e->type == E_LEQ ? E_GTH : E_LTH;
+			break;
+		case E_LTH:
+		case E_GTH:
+			// !a<'x' -> a>='x'
+			tmp = e->left.expr;
+			free(e);
+			e = tmp;
+			e->type = e->type == E_LTH ? E_GEQ : E_LEQ;
+			break;
 		case E_OR:
 			// !(a || b) -> !a && !b
 			tmp = e->left.expr;
@@ -783,6 +761,10 @@ int expr_contains_symbol(struct expr *dep, struct symbol *sym)
 	case E_SYMBOL:
 		return dep->left.sym == sym;
 	case E_EQUAL:
+	case E_GEQ:
+	case E_GTH:
+	case E_LEQ:
+	case E_LTH:
 	case E_UNEQUAL:
 		return dep->left.sym == sym ||
 		       dep->right.sym == sym;
@@ -823,57 +805,6 @@ bool expr_depends_symbol(struct expr *dep, struct symbol *sym)
  	return false;
 }
 
-struct expr *expr_extract_eq_and(struct expr **ep1, struct expr **ep2)
-{
-	struct expr *tmp = NULL;
-	expr_extract_eq(E_AND, &tmp, ep1, ep2);
-	if (tmp) {
-		*ep1 = expr_eliminate_yn(*ep1);
-		*ep2 = expr_eliminate_yn(*ep2);
-	}
-	return tmp;
-}
-
-struct expr *expr_extract_eq_or(struct expr **ep1, struct expr **ep2)
-{
-	struct expr *tmp = NULL;
-	expr_extract_eq(E_OR, &tmp, ep1, ep2);
-	if (tmp) {
-		*ep1 = expr_eliminate_yn(*ep1);
-		*ep2 = expr_eliminate_yn(*ep2);
-	}
-	return tmp;
-}
-
-void expr_extract_eq(enum expr_type type, struct expr **ep, struct expr **ep1, struct expr **ep2)
-{
-#define e1 (*ep1)
-#define e2 (*ep2)
-	if (e1->type == type) {
-		expr_extract_eq(type, ep, &e1->left.expr, &e2);
-		expr_extract_eq(type, ep, &e1->right.expr, &e2);
-		return;
-	}
-	if (e2->type == type) {
-		expr_extract_eq(type, ep, ep1, &e2->left.expr);
-		expr_extract_eq(type, ep, ep1, &e2->right.expr);
-		return;
-	}
-	if (expr_eq(e1, e2)) {
-		*ep = *ep ? expr_alloc_two(type, *ep, e1) : e1;
-		expr_free(e2);
-		if (type == E_AND) {
-			e1 = expr_alloc_symbol(&symbol_yes);
-			e2 = expr_alloc_symbol(&symbol_yes);
-		} else if (type == E_OR) {
-			e1 = expr_alloc_symbol(&symbol_no);
-			e2 = expr_alloc_symbol(&symbol_no);
-		}
-	}
-#undef e1
-#undef e2
-}
-
 struct expr *expr_trans_compare(struct expr *e, enum expr_type type, struct symbol *sym)
 {
 	struct expr *e1, *e2;
@@ -908,6 +839,10 @@ struct expr *expr_trans_compare(struct expr *e, enum expr_type type, struct symb
 	case E_NOT:
 		return expr_trans_compare(e->left.expr, type == E_EQUAL ? E_UNEQUAL : E_EQUAL, sym);
 	case E_UNEQUAL:
+	case E_LTH:
+	case E_LEQ:
+	case E_GTH:
+	case E_GEQ:
 	case E_EQUAL:
 		if (type == E_EQUAL) {
 			if (sym == &symbol_yes)
@@ -935,10 +870,57 @@ struct expr *expr_trans_compare(struct expr *e, enum expr_type type, struct symb
 	return NULL;
 }
 
+enum string_value_kind {
+	k_string,
+	k_signed,
+	k_unsigned,
+	k_invalid
+};
+
+union string_value {
+	unsigned long long u;
+	signed long long s;
+};
+
+static enum string_value_kind expr_parse_string(const char *str,
+						enum symbol_type type,
+						union string_value *val)
+{
+	char *tail;
+	enum string_value_kind kind;
+
+	errno = 0;
+	switch (type) {
+	case S_BOOLEAN:
+	case S_TRISTATE:
+		return k_string;
+	case S_INT:
+		val->s = strtoll(str, &tail, 10);
+		kind = k_signed;
+		break;
+	case S_HEX:
+		val->u = strtoull(str, &tail, 16);
+		kind = k_unsigned;
+		break;
+	case S_STRING:
+	case S_UNKNOWN:
+		val->s = strtoll(str, &tail, 0);
+		kind = k_signed;
+		break;
+	default:
+		return k_invalid;
+	}
+	return !errno && !*tail && tail > str && isxdigit(tail[-1])
+	       ? kind : k_string;
+}
+
 tristate expr_calc_value(struct expr *e)
 {
 	tristate val1, val2;
 	const char *str1, *str2;
+	enum string_value_kind k1 = k_string, k2 = k_string;
+	union string_value lval = {}, rval = {};
+	int res;
 
 	if (!e)
 		return yes;
@@ -959,31 +941,70 @@ tristate expr_calc_value(struct expr *e)
 		val1 = expr_calc_value(e->left.expr);
 		return EXPR_NOT(val1);
 	case E_EQUAL:
-		sym_calc_value(e->left.sym);
-		sym_calc_value(e->right.sym);
-		str1 = sym_get_string_value(e->left.sym);
-		str2 = sym_get_string_value(e->right.sym);
-		return !strcmp(str1, str2) ? yes : no;
+	case E_GEQ:
+	case E_GTH:
+	case E_LEQ:
+	case E_LTH:
 	case E_UNEQUAL:
-		sym_calc_value(e->left.sym);
-		sym_calc_value(e->right.sym);
-		str1 = sym_get_string_value(e->left.sym);
-		str2 = sym_get_string_value(e->right.sym);
-		return !strcmp(str1, str2) ? no : yes;
+		break;
 	default:
 		printf("expr_calc_value: %d?\n", e->type);
 		return no;
 	}
+
+	sym_calc_value(e->left.sym);
+	sym_calc_value(e->right.sym);
+	str1 = sym_get_string_value(e->left.sym);
+	str2 = sym_get_string_value(e->right.sym);
+
+	if (e->left.sym->type != S_STRING || e->right.sym->type != S_STRING) {
+		k1 = expr_parse_string(str1, e->left.sym->type, &lval);
+		k2 = expr_parse_string(str2, e->right.sym->type, &rval);
+	}
+
+	if (k1 == k_string || k2 == k_string)
+		res = strcmp(str1, str2);
+	else if (k1 == k_invalid || k2 == k_invalid) {
+		if (e->type != E_EQUAL && e->type != E_UNEQUAL) {
+			printf("Cannot compare \"%s\" and \"%s\"\n", str1, str2);
+			return no;
+		}
+		res = strcmp(str1, str2);
+	} else if (k1 == k_unsigned || k2 == k_unsigned)
+		res = (lval.u > rval.u) - (lval.u < rval.u);
+	else /* if (k1 == k_signed && k2 == k_signed) */
+		res = (lval.s > rval.s) - (lval.s < rval.s);
+
+	switch(e->type) {
+	case E_EQUAL:
+		return res ? no : yes;
+	case E_GEQ:
+		return res >= 0 ? yes : no;
+	case E_GTH:
+		return res > 0 ? yes : no;
+	case E_LEQ:
+		return res <= 0 ? yes : no;
+	case E_LTH:
+		return res < 0 ? yes : no;
+	case E_UNEQUAL:
+		return res ? yes : no;
+	default:
+		printf("expr_calc_value: relation %d?\n", e->type);
+		return no;
+	}
 }
 
-int expr_compare_type(enum expr_type t1, enum expr_type t2)
+static int expr_compare_type(enum expr_type t1, enum expr_type t2)
 {
-#if 0
-	return 1;
-#else
 	if (t1 == t2)
 		return 0;
 	switch (t1) {
+	case E_LEQ:
+	case E_LTH:
+	case E_GEQ:
+	case E_GTH:
+		if (t2 == E_EQUAL || t2 == E_UNEQUAL)
+			return 1;
 	case E_EQUAL:
 	case E_UNEQUAL:
 		if (t2 == E_NOT)
@@ -1005,7 +1026,6 @@ int expr_compare_type(enum expr_type t1, enum expr_type t2)
 	}
 	printf("[%dgt%d?]", t1, t2);
 	return 0;
-#endif
 }
 
 static inline struct expr *
@@ -1078,6 +1098,24 @@ void expr_print(struct expr *e, void (*fn)(void *, struct symbol *, const char *
 		fn(data, NULL, "=");
 		fn(data, e->right.sym, e->right.sym->name);
 		break;
+	case E_LEQ:
+	case E_LTH:
+		if (e->left.sym->name)
+			fn(data, e->left.sym, e->left.sym->name);
+		else
+			fn(data, NULL, "<choice>");
+		fn(data, NULL, e->type == E_LEQ ? "<=" : "<");
+		fn(data, e->right.sym, e->right.sym->name);
+		break;
+	case E_GEQ:
+	case E_GTH:
+		if (e->left.sym->name)
+			fn(data, e->left.sym, e->left.sym->name);
+		else
+			fn(data, NULL, "<choice>");
+		fn(data, NULL, e->type == E_LEQ ? ">=" : ">");
+		fn(data, e->right.sym, e->right.sym->name);
+		break;
 	case E_UNEQUAL:
 		if (e->left.sym->name)
 			fn(data, e->left.sym, e->left.sym->name);
diff --git a/backport/kconf/expr.h b/backport/kconf/expr.h
index cdd48600e02a..973b6f733368 100644
--- a/backport/kconf/expr.h
+++ b/backport/kconf/expr.h
@@ -29,7 +29,9 @@ typedef enum tristate {
 } tristate;
 
 enum expr_type {
-	E_NONE, E_OR, E_AND, E_NOT, E_EQUAL, E_UNEQUAL, E_LIST, E_SYMBOL, E_RANGE
+	E_NONE, E_OR, E_AND, E_NOT,
+	E_EQUAL, E_UNEQUAL, E_LTH, E_LEQ, E_GTH, E_GEQ,
+	E_LIST, E_SYMBOL, E_RANGE
 };
 
 union expr_data {
@@ -93,7 +95,7 @@ struct symbol {
 #define SYMBOL_CHOICEVAL  0x0020  /* used as a value in a choice block */
 #define SYMBOL_VALID      0x0080  /* set when symbol.curr is calculated */
 #define SYMBOL_OPTIONAL   0x0100  /* choice is optional - values can be 'n' */
-#define SYMBOL_WRITE      0x0200  /* ? */
+#define SYMBOL_WRITE      0x0200  /* write symbol to file (KCONFIG_CONFIG) */
 #define SYMBOL_CHANGED    0x0400  /* ? */
 #define SYMBOL_AUTO       0x1000  /* value from environment variable */
 #define SYMBOL_CHECKED    0x2000  /* used during dependency checking */
@@ -106,6 +108,12 @@ struct symbol {
 #define SYMBOL_DEF3       0x40000  /* symbol.def[S_DEF_3] is valid */
 #define SYMBOL_DEF4       0x80000  /* symbol.def[S_DEF_4] is valid */
 
+/* choice values need to be set before calculating this symbol value */
+#define SYMBOL_NEED_SET_CHOICE_VALUES  0x100000
+
+/* Set symbol to y if allnoconfig; used for symbols that hide others */
+#define SYMBOL_ALLNOCONFIG_Y 0x200000
+
 #define SYMBOL_MAXLENGTH	256
 #define SYMBOL_HASHSIZE		9973
 
@@ -199,18 +207,13 @@ struct expr *expr_alloc_and(struct expr *e1, struct expr *e2);
 struct expr *expr_alloc_or(struct expr *e1, struct expr *e2);
 struct expr *expr_copy(const struct expr *org);
 void expr_free(struct expr *e);
-int expr_eq(struct expr *e1, struct expr *e2);
 void expr_eliminate_eq(struct expr **ep1, struct expr **ep2);
 tristate expr_calc_value(struct expr *e);
-struct expr *expr_eliminate_yn(struct expr *e);
 struct expr *expr_trans_bool(struct expr *e);
 struct expr *expr_eliminate_dups(struct expr *e);
 struct expr *expr_transform(struct expr *e);
 int expr_contains_symbol(struct expr *dep, struct symbol *sym);
 bool expr_depends_symbol(struct expr *dep, struct symbol *sym);
-struct expr *expr_extract_eq_and(struct expr **ep1, struct expr **ep2);
-struct expr *expr_extract_eq_or(struct expr **ep1, struct expr **ep2);
-void expr_extract_eq(enum expr_type type, struct expr **ep, struct expr **ep1, struct expr **ep2);
 struct expr *expr_trans_compare(struct expr *e, enum expr_type type, struct symbol *sym);
 struct expr *expr_simplify_unmet_dep(struct expr *e1, struct expr *e2);
 
diff --git a/backport/kconf/list.h b/backport/kconf/list.h
index 0ae730be5f49..2cf23f002d3f 100644
--- a/backport/kconf/list.h
+++ b/backport/kconf/list.h
@@ -34,7 +34,7 @@ struct list_head {
  * list_entry - get the struct for this entry
  * @ptr:	the &struct list_head pointer.
  * @type:	the type of the struct this is embedded in.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  */
 #define list_entry(ptr, type, member) \
 	container_of(ptr, type, member)
@@ -43,7 +43,7 @@ struct list_head {
  * list_for_each_entry	-	iterate over list of given type
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  */
 #define list_for_each_entry(pos, head, member)				\
 	for (pos = list_entry((head)->next, typeof(*pos), member);	\
@@ -51,6 +51,19 @@ struct list_head {
 	     pos = list_entry(pos->member.next, typeof(*pos), member))
 
 /**
+ * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
+ * @pos:	the type * to use as a loop cursor.
+ * @n:		another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ */
+#define list_for_each_entry_safe(pos, n, head, member)			\
+	for (pos = list_entry((head)->next, typeof(*pos), member),	\
+		n = list_entry(pos->member.next, typeof(*pos), member);	\
+	     &pos->member != (head);					\
+	     pos = n, n = list_entry(n->member.next, typeof(*n), member))
+
+/**
  * list_empty - tests whether a list is empty
  * @head: the list to test.
  */
@@ -88,4 +101,31 @@ static inline void list_add_tail(struct list_head *_new, struct list_head *head)
 	__list_add(_new, head->prev, head);
 }
 
+/*
+ * Delete a list entry by making the prev/next entries
+ * point to each other.
+ *
+ * This is only for internal list manipulation where we know
+ * the prev/next entries already!
+ */
+static inline void __list_del(struct list_head *prev, struct list_head *next)
+{
+	next->prev = prev;
+	prev->next = next;
+}
+
+#define LIST_POISON1  ((void *) 0x00100100)
+#define LIST_POISON2  ((void *) 0x00200200)
+/**
+ * list_del - deletes entry from list.
+ * @entry: the element to delete from the list.
+ * Note: list_empty() on entry does not return true after this, the entry is
+ * in an undefined state.
+ */
+static inline void list_del(struct list_head *entry)
+{
+	__list_del(entry->prev, entry->next);
+	entry->next = (struct list_head*)LIST_POISON1;
+	entry->prev = (struct list_head*)LIST_POISON2;
+}
 #endif
diff --git a/backport/kconf/lkc.h b/backport/kconf/lkc.h
index f8aee5fc6d5e..91ca126ea080 100644
--- a/backport/kconf/lkc.h
+++ b/backport/kconf/lkc.h
@@ -21,9 +21,7 @@ static inline char *bind_textdomain_codeset(const char *dn, char *c) { return c;
 extern "C" {
 #endif
 
-#define P(name,type,arg)	extern type name arg
 #include "lkc_proto.h"
-#undef P
 
 #define SRCTREE "srctree"
 
@@ -61,6 +59,7 @@ enum conf_def_mode {
 #define T_OPT_MODULES		1
 #define T_OPT_DEFCONFIG_LIST	2
 #define T_OPT_ENV		3
+#define T_OPT_ALLNOCONFIG_Y	4
 
 struct kconf_id {
 	int name;
@@ -69,9 +68,6 @@ struct kconf_id {
 	enum symbol_type stype;
 };
 
-extern int zconfdebug;
-
-int zconfparse(void);
 void zconfdump(FILE *out);
 void zconf_starthelp(void);
 FILE *zconf_fopen(const char *name);
@@ -86,12 +82,8 @@ const char *conf_get_autoconfig_name(void);
 char *conf_get_default_confname(void);
 void sym_set_change_count(int count);
 void sym_add_change_count(int count);
-void conf_set_all_new_symbols(enum conf_def_mode mode);
-
-struct conf_printer {
-	void (*print_symbol)(FILE *, struct symbol *, const char *, void *);
-	void (*print_comment)(FILE *, const char *, void *);
-};
+bool conf_set_all_new_symbols(enum conf_def_mode mode);
+void set_all_choice_values(struct symbol *csym);
 
 /* confdata.c and expr.c */
 static inline void xfwrite(const void *str, size_t len, size_t count, FILE *out)
@@ -111,7 +103,6 @@ void menu_add_entry(struct symbol *sym);
 void menu_end_entry(void);
 void menu_add_dep(struct expr *dep);
 void menu_add_visibility(struct expr *dep);
-struct property *menu_add_prop(enum prop_type type, char *prompt, struct expr *expr, struct expr *dep);
 struct property *menu_add_prompt(enum prop_type type, char *prompt, struct expr *dep);
 void menu_add_expr(enum prop_type type, struct expr *expr, struct expr *dep);
 void menu_add_symbol(enum prop_type type, struct symbol *sym, struct expr *dep);
@@ -135,7 +126,6 @@ struct gstr {
 	int max_width;
 };
 struct gstr str_new(void);
-struct gstr str_assign(const char *s);
 void str_free(struct gstr *gs);
 void str_append(struct gstr *gs, const char *s);
 void str_printf(struct gstr *gs, const char *fmt, ...);
@@ -146,8 +136,6 @@ extern struct expr *sym_env_list;
 
 void sym_init(void);
 void sym_clear_all_valid(void);
-void sym_set_all_changed(void);
-void sym_set_changed(struct symbol *sym);
 struct symbol *sym_choice_default(struct symbol *sym);
 const char *sym_get_string_default(struct symbol *sym);
 struct symbol *sym_check_deps(struct symbol *sym);
diff --git a/backport/kconf/lkc_proto.h b/backport/kconf/lkc_proto.h
index ef1a7381f956..d5398718ec2a 100644
--- a/backport/kconf/lkc_proto.h
+++ b/backport/kconf/lkc_proto.h
@@ -1,56 +1,52 @@
 #include <stdarg.h>
 
 /* confdata.c */
-P(conf_parse,void,(const char *name));
-P(conf_read,int,(const char *name));
-P(conf_read_simple,int,(const char *name, int));
-P(conf_write_defconfig,int,(const char *name));
-P(conf_write,int,(const char *name));
-P(conf_write_autoconf,int,(void));
-P(conf_get_changed,bool,(void));
-P(conf_set_changed_callback, void,(void (*fn)(void)));
-P(conf_set_message_callback, void,(void (*fn)(const char *fmt, va_list ap)));
+void conf_parse(const char *name);
+int conf_read(const char *name);
+int conf_read_simple(const char *name, int);
+int conf_write_defconfig(const char *name);
+int conf_write(const char *name);
+int conf_write_autoconf(void);
+bool conf_get_changed(void);
+void conf_set_changed_callback(void (*fn)(void));
+void conf_set_message_callback(void (*fn)(const char *fmt, va_list ap));
 
 /* menu.c */
-P(rootmenu,struct menu,);
+extern struct menu rootmenu;
 
-P(menu_is_visible, bool, (struct menu *menu));
-P(menu_has_prompt, bool, (struct menu *menu));
-P(menu_get_prompt,const char *,(struct menu *menu));
-P(menu_get_root_menu,struct menu *,(struct menu *menu));
-P(menu_get_parent_menu,struct menu *,(struct menu *menu));
-P(menu_has_help,bool,(struct menu *menu));
-P(menu_get_help,const char *,(struct menu *menu));
-P(get_symbol_str, void, (struct gstr *r, struct symbol *sym, struct list_head
-			 *head));
-P(get_relations_str, struct gstr, (struct symbol **sym_arr, struct list_head
-				   *head));
-P(menu_get_ext_help,void,(struct menu *menu, struct gstr *help));
+bool menu_is_empty(struct menu *menu);
+bool menu_is_visible(struct menu *menu);
+bool menu_has_prompt(struct menu *menu);
+const char * menu_get_prompt(struct menu *menu);
+struct menu * menu_get_root_menu(struct menu *menu);
+struct menu * menu_get_parent_menu(struct menu *menu);
+bool menu_has_help(struct menu *menu);
+const char * menu_get_help(struct menu *menu);
+struct gstr get_relations_str(struct symbol **sym_arr, struct list_head *head);
+void menu_get_ext_help(struct menu *menu, struct gstr *help);
 
 /* symbol.c */
-P(symbol_hash,struct symbol *,[SYMBOL_HASHSIZE]);
+extern struct symbol * symbol_hash[SYMBOL_HASHSIZE];
 
-P(sym_lookup,struct symbol *,(const char *name, int flags));
-P(sym_find,struct symbol *,(const char *name));
-P(sym_expand_string_value,const char *,(const char *in));
-P(sym_escape_string_value, const char *,(const char *in));
-P(sym_re_search,struct symbol **,(const char *pattern));
-P(sym_type_name,const char *,(enum symbol_type type));
-P(sym_calc_value,void,(struct symbol *sym));
-P(sym_get_type,enum symbol_type,(struct symbol *sym));
-P(sym_tristate_within_range,bool,(struct symbol *sym,tristate tri));
-P(sym_set_tristate_value,bool,(struct symbol *sym,tristate tri));
-P(sym_toggle_tristate_value,tristate,(struct symbol *sym));
-P(sym_string_valid,bool,(struct symbol *sym, const char *newval));
-P(sym_string_within_range,bool,(struct symbol *sym, const char *str));
-P(sym_set_string_value,bool,(struct symbol *sym, const char *newval));
-P(sym_is_changable,bool,(struct symbol *sym));
-P(sym_get_choice_prop,struct property *,(struct symbol *sym));
-P(sym_get_default_prop,struct property *,(struct symbol *sym));
-P(sym_get_string_value,const char *,(struct symbol *sym));
+struct symbol * sym_lookup(const char *name, int flags);
+struct symbol * sym_find(const char *name);
+const char * sym_expand_string_value(const char *in);
+const char * sym_escape_string_value(const char *in);
+struct symbol ** sym_re_search(const char *pattern);
+const char * sym_type_name(enum symbol_type type);
+void sym_calc_value(struct symbol *sym);
+enum symbol_type sym_get_type(struct symbol *sym);
+bool sym_tristate_within_range(struct symbol *sym,tristate tri);
+bool sym_set_tristate_value(struct symbol *sym,tristate tri);
+tristate sym_toggle_tristate_value(struct symbol *sym);
+bool sym_string_valid(struct symbol *sym, const char *newval);
+bool sym_string_within_range(struct symbol *sym, const char *str);
+bool sym_set_string_value(struct symbol *sym, const char *newval);
+bool sym_is_changable(struct symbol *sym);
+struct property * sym_get_choice_prop(struct symbol *sym);
+const char * sym_get_string_value(struct symbol *sym);
 
-P(prop_get_type_name,const char *,(enum prop_type type));
+const char * prop_get_type_name(enum prop_type type);
 
 /* expr.c */
-P(expr_compare_type,int,(enum expr_type t1, enum expr_type t2));
-P(expr_print,void,(struct expr *e, void (*fn)(void *, struct symbol *, const char *), void *data, int prevtoken));
+void expr_print(struct expr *e, void (*fn)(void *, struct symbol *, const char *), void *data, int prevtoken);
diff --git a/backport/kconf/lxdialog/check-lxdialog.sh b/backport/kconf/lxdialog/check-lxdialog.sh
index 80788137c670..5075ebf2d3b9 100755
--- a/backport/kconf/lxdialog/check-lxdialog.sh
+++ b/backport/kconf/lxdialog/check-lxdialog.sh
@@ -4,6 +4,8 @@
 # What library to link
 ldflags()
 {
+	pkg-config --libs ncursesw 2>/dev/null && exit
+	pkg-config --libs ncurses 2>/dev/null && exit
 	for ext in so a dll.a dylib ; do
 		for lib in ncursesw ncurses curses ; do
 			$cc -print-file-name=lib${lib}.${ext} | grep -q /
@@ -19,13 +21,17 @@ ldflags()
 # Where is ncurses.h?
 ccflags()
 {
-	if [ -f /usr/include/ncursesw/curses.h ]; then
-		echo '-I/usr/include/ncursesw -DCURSES_LOC="<ncursesw/curses.h>"'
+	if pkg-config --cflags ncursesw 2>/dev/null; then
+		echo '-DCURSES_LOC="<ncurses.h>" -DNCURSES_WIDECHAR=1'
+	elif pkg-config --cflags ncurses 2>/dev/null; then
+		echo '-DCURSES_LOC="<ncurses.h>"'
+	elif [ -f /usr/include/ncursesw/curses.h ]; then
+		echo '-I/usr/include/ncursesw -DCURSES_LOC="<curses.h>"'
 		echo ' -DNCURSES_WIDECHAR=1'
 	elif [ -f /usr/include/ncurses/ncurses.h ]; then
 		echo '-I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>"'
 	elif [ -f /usr/include/ncurses/curses.h ]; then
-		echo '-I/usr/include/ncurses -DCURSES_LOC="<ncurses/curses.h>"'
+		echo '-I/usr/include/ncurses -DCURSES_LOC="<curses.h>"'
 	elif [ -f /usr/include/ncurses.h ]; then
 		echo '-DCURSES_LOC="<ncurses.h>"'
 	else
diff --git a/backport/kconf/lxdialog/checklist.c b/backport/kconf/lxdialog/checklist.c
index a2eb80fbc896..8d016faa28d7 100644
--- a/backport/kconf/lxdialog/checklist.c
+++ b/backport/kconf/lxdialog/checklist.c
@@ -132,16 +132,16 @@ int dialog_checklist(const char *title, const char *prompt, int height,
 	}
 
 do_resize:
-	if (getmaxy(stdscr) < (height + 6))
+	if (getmaxy(stdscr) < (height + CHECKLIST_HEIGTH_MIN))
 		return -ERRDISPLAYTOOSMALL;
-	if (getmaxx(stdscr) < (width + 6))
+	if (getmaxx(stdscr) < (width + CHECKLIST_WIDTH_MIN))
 		return -ERRDISPLAYTOOSMALL;
 
 	max_choice = MIN(list_height, item_count());
 
 	/* center dialog box on screen */
-	x = (COLS - width) / 2;
-	y = (LINES - height) / 2;
+	x = (getmaxx(stdscr) - width) / 2;
+	y = (getmaxy(stdscr) - height) / 2;
 
 	draw_shadow(stdscr, y, x, height, width);
 
@@ -168,13 +168,13 @@ do_resize:
 
 	/* create new window for the list */
 	list = subwin(dialog, list_height, list_width, y + box_y + 1,
-	              x + box_x + 1);
+		      x + box_x + 1);
 
 	keypad(list, TRUE);
 
 	/* draw a box around the list items */
 	draw_box(dialog, box_y, box_x, list_height + 2, list_width + 2,
-	         dlg.menubox_border.atr, dlg.menubox.atr);
+		 dlg.menubox_border.atr, dlg.menubox.atr);
 
 	/* Find length of longest item in order to center checklist */
 	check_x = 0;
diff --git a/backport/kconf/lxdialog/dialog.h b/backport/kconf/lxdialog/dialog.h
index aa3d6d9a3386..fcffd5b41fb0 100644
--- a/backport/kconf/lxdialog/dialog.h
+++ b/backport/kconf/lxdialog/dialog.h
@@ -35,7 +35,7 @@
 #ifdef __sun__
 #define CURS_MACROS
 #endif
-#include <ncurses.h>
+#include CURSES_LOC
 
 /*
  * Colors in ncurses 1.9.9e do not work properly since foreground and
@@ -106,8 +106,14 @@ struct dialog_color {
 	int hl;		/* highlight this item */
 };
 
+struct subtitle_list {
+	struct subtitle_list *next;
+	const char *text;
+};
+
 struct dialog_info {
 	const char *backtitle;
+	struct subtitle_list *subtitles;
 	struct dialog_color screen;
 	struct dialog_color shadow;
 	struct dialog_color dialog;
@@ -164,7 +170,7 @@ char item_tag(void);
 /* item list manipulation for lxdialog use */
 #define MAXITEMSTR 200
 struct dialog_item {
-	char str[MAXITEMSTR];	/* promtp displayed */
+	char str[MAXITEMSTR];	/* prompt displayed */
 	char tag;
 	void *data;	/* pointer to menu item - used by menubox+checklist */
 	int selected;	/* Set to 1 by dialog_*() function if selected. */
@@ -194,8 +200,23 @@ int item_is_tag(char tag);
 int on_key_esc(WINDOW *win);
 int on_key_resize(void);
 
+/* minimum (re)size values */
+#define CHECKLIST_HEIGTH_MIN 6	/* For dialog_checklist() */
+#define CHECKLIST_WIDTH_MIN 6
+#define INPUTBOX_HEIGTH_MIN 2	/* For dialog_inputbox() */
+#define INPUTBOX_WIDTH_MIN 2
+#define MENUBOX_HEIGTH_MIN 15	/* For dialog_menu() */
+#define MENUBOX_WIDTH_MIN 65
+#define TEXTBOX_HEIGTH_MIN 8	/* For dialog_textbox() */
+#define TEXTBOX_WIDTH_MIN 8
+#define YESNO_HEIGTH_MIN 4	/* For dialog_yesno() */
+#define YESNO_WIDTH_MIN 4
+#define WINDOW_HEIGTH_MIN 19	/* For init_dialog() */
+#define WINDOW_WIDTH_MIN 80
+
 int init_dialog(const char *backtitle);
 void set_dialog_backtitle(const char *backtitle);
+void set_dialog_subtitles(struct subtitle_list *subtitles);
 void end_dialog(int x, int y);
 void attr_clear(WINDOW * win, int height, int width, chtype attr);
 void dialog_clear(void);
diff --git a/backport/kconf/lxdialog/inputbox.c b/backport/kconf/lxdialog/inputbox.c
index 21404a04d7c3..d58de1dc5360 100644
--- a/backport/kconf/lxdialog/inputbox.c
+++ b/backport/kconf/lxdialog/inputbox.c
@@ -42,7 +42,7 @@ static void print_buttons(WINDOW * dialog, int height, int width, int selected)
  * Display a dialog box for inputing a string
  */
 int dialog_inputbox(const char *title, const char *prompt, int height, int width,
-                    const char *init)
+		    const char *init)
 {
 	int i, x, y, box_y, box_x, box_width;
 	int input_x = 0, key = 0, button = -1;
@@ -56,14 +56,14 @@ int dialog_inputbox(const char *title, const char *prompt, int height, int width
 		strcpy(instr, init);
 
 do_resize:
-	if (getmaxy(stdscr) <= (height - 2))
+	if (getmaxy(stdscr) <= (height - INPUTBOX_HEIGTH_MIN))
 		return -ERRDISPLAYTOOSMALL;
-	if (getmaxx(stdscr) <= (width - 2))
+	if (getmaxx(stdscr) <= (width - INPUTBOX_WIDTH_MIN))
 		return -ERRDISPLAYTOOSMALL;
 
 	/* center dialog box on screen */
-	x = (COLS - width) / 2;
-	y = (LINES - height) / 2;
+	x = (getmaxx(stdscr) - width) / 2;
+	y = (getmaxy(stdscr) - height) / 2;
 
 	draw_shadow(stdscr, y, x, height, width);
 
diff --git a/backport/kconf/lxdialog/menubox.c b/backport/kconf/lxdialog/menubox.c
index 48d382e7e374..11ae9ad7ac7b 100644
--- a/backport/kconf/lxdialog/menubox.c
+++ b/backport/kconf/lxdialog/menubox.c
@@ -64,7 +64,7 @@ static int menu_width, item_x;
  * Print menu item
  */
 static void do_print_item(WINDOW * win, const char *item, int line_y,
-                          int selected, int hotkey)
+			  int selected, int hotkey)
 {
 	int j;
 	char *menu_item = malloc(menu_width + 1);
@@ -182,7 +182,7 @@ static void do_scroll(WINDOW *win, int *scroll, int n)
  * Display a menu for choosing among a number of options
  */
 int dialog_menu(const char *title, const char *prompt,
-                const void *selected, int *s_scroll)
+		const void *selected, int *s_scroll)
 {
 	int i, j, x, y, box_x, box_y;
 	int height, width, menu_height;
@@ -193,7 +193,7 @@ int dialog_menu(const char *title, const char *prompt,
 do_resize:
 	height = getmaxy(stdscr);
 	width = getmaxx(stdscr);
-	if (height < 15 || width < 65)
+	if (height < MENUBOX_HEIGTH_MIN || width < MENUBOX_WIDTH_MIN)
 		return -ERRDISPLAYTOOSMALL;
 
 	height -= 4;
@@ -203,8 +203,8 @@ do_resize:
 	max_choice = MIN(menu_height, item_count());
 
 	/* center dialog box on screen */
-	x = (COLS - width) / 2;
-	y = (LINES - height) / 2;
+	x = (getmaxx(stdscr) - width) / 2;
+	y = (getmaxy(stdscr) - height) / 2;
 
 	draw_shadow(stdscr, y, x, height, width);
 
@@ -303,10 +303,11 @@ do_resize:
 				}
 		}
 
-		if (i < max_choice ||
-		    key == KEY_UP || key == KEY_DOWN ||
-		    key == '-' || key == '+' ||
-		    key == KEY_PPAGE || key == KEY_NPAGE) {
+		if (item_count() != 0 &&
+		    (i < max_choice ||
+		     key == KEY_UP || key == KEY_DOWN ||
+		     key == '-' || key == '+' ||
+		     key == KEY_PPAGE || key == KEY_NPAGE)) {
 			/* Remove highligt of current item */
 			print_item(scroll + choice, choice, FALSE);
 
diff --git a/backport/kconf/lxdialog/textbox.c b/backport/kconf/lxdialog/textbox.c
index a48bb93e0907..1773319b95e7 100644
--- a/backport/kconf/lxdialog/textbox.c
+++ b/backport/kconf/lxdialog/textbox.c
@@ -80,7 +80,7 @@ int dialog_textbox(const char *title, char *tbuf, int initial_height,
 
 do_resize:
 	getmaxyx(stdscr, height, width);
-	if (height < 8 || width < 8)
+	if (height < TEXTBOX_HEIGTH_MIN || width < TEXTBOX_WIDTH_MIN)
 		return -ERRDISPLAYTOOSMALL;
 	if (initial_height != 0)
 		height = initial_height;
@@ -98,8 +98,8 @@ do_resize:
 			width = 0;
 
 	/* center dialog box on screen */
-	x = (COLS - width) / 2;
-	y = (LINES - height) / 2;
+	x = (getmaxx(stdscr) - width) / 2;
+	y = (getmaxy(stdscr) - height) / 2;
 
 	draw_shadow(stdscr, y, x, height, width);
 
diff --git a/backport/kconf/lxdialog/util.c b/backport/kconf/lxdialog/util.c
index 109d53117d22..f7abdeb92af0 100644
--- a/backport/kconf/lxdialog/util.c
+++ b/backport/kconf/lxdialog/util.c
@@ -254,15 +254,56 @@ void attr_clear(WINDOW * win, int height, int width, chtype attr)
 
 void dialog_clear(void)
 {
-	attr_clear(stdscr, LINES, COLS, dlg.screen.atr);
+	int lines, columns;
+
+	lines = getmaxy(stdscr);
+	columns = getmaxx(stdscr);
+
+	attr_clear(stdscr, lines, columns, dlg.screen.atr);
 	/* Display background title if it exists ... - SLH */
 	if (dlg.backtitle != NULL) {
-		int i;
+		int i, len = 0, skip = 0;
+		struct subtitle_list *pos;
 
 		wattrset(stdscr, dlg.screen.atr);
 		mvwaddstr(stdscr, 0, 1, (char *)dlg.backtitle);
+
+		for (pos = dlg.subtitles; pos != NULL; pos = pos->next) {
+			/* 3 is for the arrow and spaces */
+			len += strlen(pos->text) + 3;
+		}
+
 		wmove(stdscr, 1, 1);
-		for (i = 1; i < COLS - 1; i++)
+		if (len > columns - 2) {
+			const char *ellipsis = "[...] ";
+			waddstr(stdscr, ellipsis);
+			skip = len - (columns - 2 - strlen(ellipsis));
+		}
+
+		for (pos = dlg.subtitles; pos != NULL; pos = pos->next) {
+			if (skip == 0)
+				waddch(stdscr, ACS_RARROW);
+			else
+				skip--;
+
+			if (skip == 0)
+				waddch(stdscr, ' ');
+			else
+				skip--;
+
+			if (skip < strlen(pos->text)) {
+				waddstr(stdscr, pos->text + skip);
+				skip = 0;
+			} else
+				skip -= strlen(pos->text);
+
+			if (skip == 0)
+				waddch(stdscr, ' ');
+			else
+				skip--;
+		}
+
+		for (i = len + 1; i < columns - 1; i++)
 			waddch(stdscr, ACS_HLINE);
 	}
 	wnoutrefresh(stdscr);
@@ -281,7 +322,7 @@ int init_dialog(const char *backtitle)
 	getyx(stdscr, saved_y, saved_x);
 
 	getmaxyx(stdscr, height, width);
-	if (height < 19 || width < 80) {
+	if (height < WINDOW_HEIGTH_MIN || width < WINDOW_WIDTH_MIN) {
 		endwin();
 		return -ERRDISPLAYTOOSMALL;
 	}
@@ -302,6 +343,11 @@ void set_dialog_backtitle(const char *backtitle)
 	dlg.backtitle = backtitle;
 }
 
+void set_dialog_subtitles(struct subtitle_list *subtitles)
+{
+	dlg.subtitles = subtitles;
+}
+
 /*
  * End using dialog functions.
  */
@@ -330,27 +376,19 @@ void print_title(WINDOW *dialog, const char *title, int width)
 /*
  * Print a string of text in a window, automatically wrap around to the
  * next line if the string is too long to fit on one line. Newline
- * characters '\n' are replaced by spaces.  We start on a new line
+ * characters '\n' are propperly processed.  We start on a new line
  * if there is no room for at least 4 nonblanks following a double-space.
  */
 void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x)
 {
 	int newl, cur_x, cur_y;
-	int i, prompt_len, room, wlen;
-	char tempstr[MAX_LEN + 1], *word, *sp, *sp2;
+	int prompt_len, room, wlen;
+	char tempstr[MAX_LEN + 1], *word, *sp, *sp2, *newline_separator = 0;
 
 	strcpy(tempstr, prompt);
 
 	prompt_len = strlen(tempstr);
 
-	/*
-	 * Remove newlines
-	 */
-	for (i = 0; i < prompt_len; i++) {
-		if (tempstr[i] == '\n')
-			tempstr[i] = ' ';
-	}
-
 	if (prompt_len <= width - x * 2) {	/* If prompt is short */
 		wmove(win, y, (width - prompt_len) / 2);
 		waddstr(win, tempstr);
@@ -360,7 +398,10 @@ void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x)
 		newl = 1;
 		word = tempstr;
 		while (word && *word) {
-			sp = strchr(word, ' ');
+			sp = strpbrk(word, "\n ");
+			if (sp && *sp == '\n')
+				newline_separator = sp;
+
 			if (sp)
 				*sp++ = 0;
 
@@ -372,7 +413,7 @@ void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x)
 			if (wlen > room ||
 			    (newl && wlen < 4 && sp
 			     && wlen + 1 + strlen(sp) > room
-			     && (!(sp2 = strchr(sp, ' '))
+			     && (!(sp2 = strpbrk(sp, "\n "))
 				 || wlen + 1 + (sp2 - sp) > room))) {
 				cur_y++;
 				cur_x = x;
@@ -380,7 +421,15 @@ void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x)
 			wmove(win, cur_y, cur_x);
 			waddstr(win, word);
 			getyx(win, cur_y, cur_x);
-			cur_x++;
+
+			/* Move to the next line if the word separator was a newline */
+			if (newline_separator) {
+				cur_y++;
+				cur_x = x;
+				newline_separator = 0;
+			} else
+				cur_x++;
+
 			if (sp && *sp == ' ') {
 				cur_x++;	/* double space */
 				while (*++sp == ' ') ;
@@ -574,7 +623,7 @@ void item_make(const char *fmt, ...)
 void item_add_str(const char *fmt, ...)
 {
 	va_list ap;
-        size_t avail;
+	size_t avail;
 
 	avail = sizeof(item_cur->node.str) - strlen(item_cur->node.str);
 
diff --git a/backport/kconf/lxdialog/yesno.c b/backport/kconf/lxdialog/yesno.c
index 4e6e8090c20b..676fb2f824a3 100644
--- a/backport/kconf/lxdialog/yesno.c
+++ b/backport/kconf/lxdialog/yesno.c
@@ -45,14 +45,14 @@ int dialog_yesno(const char *title, const char *prompt, int height, int width)
 	WINDOW *dialog;
 
 do_resize:
-	if (getmaxy(stdscr) < (height + 4))
+	if (getmaxy(stdscr) < (height + YESNO_HEIGTH_MIN))
 		return -ERRDISPLAYTOOSMALL;
-	if (getmaxx(stdscr) < (width + 4))
+	if (getmaxx(stdscr) < (width + YESNO_WIDTH_MIN))
 		return -ERRDISPLAYTOOSMALL;
 
 	/* center dialog box on screen */
-	x = (COLS - width) / 2;
-	y = (LINES - height) / 2;
+	x = (getmaxx(stdscr) - width) / 2;
+	y = (getmaxy(stdscr) - height) / 2;
 
 	draw_shadow(stdscr, y, x, height, width);
 
diff --git a/backport/kconf/mconf.c b/backport/kconf/mconf.c
index 566288a76370..315ce2c7cb9d 100644
--- a/backport/kconf/mconf.c
+++ b/backport/kconf/mconf.c
@@ -25,7 +25,7 @@
 static const char mconf_readme[] = N_(
 "Overview\n"
 "--------\n"
-"This interface let you select features and parameters for the build.\n"
+"This interface lets you select features and parameters for the build.\n"
 "Features can either be built-in, modularized, or ignored. Parameters\n"
 "must be entered in as decimal or hexadecimal numbers or text.\n"
 "\n"
@@ -39,16 +39,16 @@ static const char mconf_readme[] = N_(
 "\n"
 "To change any of these features, highlight it with the cursor\n"
 "keys and press <Y> to build it in, <M> to make it a module or\n"
-"<N> to removed it.  You may also press the <Space Bar> to cycle\n"
-"through the available options (ie. Y->N->M->Y).\n"
+"<N> to remove it.  You may also press the <Space Bar> to cycle\n"
+"through the available options (i.e. Y->N->M->Y).\n"
 "\n"
 "Some additional keyboard hints:\n"
 "\n"
 "Menus\n"
 "----------\n"
-"o  Use the Up/Down arrow keys (cursor keys) to highlight the item\n"
-"   you wish to change or submenu wish to select and press <Enter>.\n"
-"   Submenus are designated by \"--->\".\n"
+"o  Use the Up/Down arrow keys (cursor keys) to highlight the item you\n"
+"   wish to change or the submenu you wish to select and press <Enter>.\n"
+"   Submenus are designated by \"--->\", empty ones by \"----\".\n"
 "\n"
 "   Shortcut: Press the option's highlighted letter (hotkey).\n"
 "             Pressing a hotkey more than once will sequence\n"
@@ -65,7 +65,7 @@ static const char mconf_readme[] = N_(
 "             there is a delayed response which you may find annoying.\n"
 "\n"
 "   Also, the <TAB> and cursor keys will cycle between <Select>,\n"
-"   <Exit> and <Help>.\n"
+"   <Exit>, <Help>, <Save>, and <Load>.\n"
 "\n"
 "o  To get help with an item, use the cursor keys to highlight <Help>\n"
 "   and press <ENTER>.\n"
@@ -105,7 +105,7 @@ static const char mconf_readme[] = N_(
 "Text Box    (Help Window)\n"
 "--------\n"
 "o  Use the cursor keys to scroll up/down/left/right.  The VI editor\n"
-"   keys h,j,k,l function here as do <u>, <d>, <SPACE BAR> and <B> for \n"
+"   keys h,j,k,l function here as do <u>, <d>, <SPACE BAR> and <B> for\n"
 "   those who are familiar with less and lynx.\n"
 "\n"
 "o  Press <E>, <X>, <q>, <Enter> or <Esc><Esc> to exit.\n"
@@ -117,23 +117,21 @@ static const char mconf_readme[] = N_(
 "those who, for various reasons, find it necessary to switch\n"
 "between different configurations.\n"
 "\n"
-"At the end of the main menu you will find two options.  One is\n"
-"for saving the current configuration to a file of your choosing.\n"
-"The other option is for loading a previously saved alternate\n"
-"configuration.\n"
+"The <Save> button will let you save the current configuration to\n"
+"a file of your choosing.  Use the <Load> button to load a previously\n"
+"saved alternate configuration.\n"
 "\n"
-"Even if you don't use alternate configuration files, but you\n"
-"find during a Menuconfig session that you have completely messed\n"
-"up your settings, you may use the \"Load Alternate...\" option to\n"
-"restore your previously saved settings from \".config\" without\n"
-"restarting Menuconfig.\n"
+"Even if you don't use alternate configuration files, but you find\n"
+"during a Menuconfig session that you have completely messed up your\n"
+"settings, you may use the <Load> button to restore your previously\n"
+"saved settings from \".config\" without restarting Menuconfig.\n"
 "\n"
 "Other information\n"
 "-----------------\n"
-"If you use Menuconfig in an XTERM window make sure you have your\n"
-"$TERM variable set to point to a xterm definition which supports color.\n"
-"Otherwise, Menuconfig will look rather bad.  Menuconfig will not\n"
-"display correctly in a RXVT window because rxvt displays only one\n"
+"If you use Menuconfig in an XTERM window, make sure you have your\n"
+"$TERM variable set to point to an xterm definition which supports\n"
+"color.  Otherwise, Menuconfig will look rather bad.  Menuconfig will\n"
+"not display correctly in an RXVT window because rxvt displays only one\n"
 "intensity of color, bright.\n"
 "\n"
 "Menuconfig will display larger menus on screens or xterms which are\n"
@@ -148,8 +146,8 @@ static const char mconf_readme[] = N_(
 "\n"
 "Optional personality available\n"
 "------------------------------\n"
-"If you prefer to have all of the options listed in a single menu, rather\n"
-"than the default multimenu hierarchy, run the menuconfig with\n"
+"If you prefer to have all of the options listed in a single menu,\n"
+"rather than the default multimenu hierarchy, run the menuconfig with\n"
 "MENUCONFIG_MODE environment variable set to single_menu. Example:\n"
 "\n"
 "make MENUCONFIG_MODE=single_menu menuconfig\n"
@@ -172,11 +170,11 @@ static const char mconf_readme[] = N_(
 " mono       => selects colors suitable for monochrome displays\n"
 " blackbg    => selects a color scheme with black background\n"
 " classic    => theme with blue background. The classic look\n"
-" bluetitle  => a LCD friendly version of classic. (default)\n"
+" bluetitle  => an LCD friendly version of classic. (default)\n"
 "\n"),
 menu_instructions[] = N_(
 	"Arrow keys navigate the menu.  "
-	"<Enter> selects submenus --->.  "
+	"<Enter> selects submenus ---> (or empty submenus ----).  "
 	"Highlighted letters are hotkeys.  "
 	"Pressing <Y> includes, <N> excludes, <M> modularizes features.  "
 	"Press <Esc><Esc> to exit, <?> for Help, </> for Search.  "
@@ -238,24 +236,24 @@ search_help[] = N_(
 	"Symbol: FOO [=m]\n"
 	"Type  : tristate\n"
 	"Prompt: Foo bus is used to drive the bar HW\n"
-	"  Defined at drivers/pci/Kconfig:47\n"
-	"  Depends on: X86_LOCAL_APIC && X86_IO_APIC || IA64\n"
 	"  Location:\n"
 	"    -> Bus options (PCI, PCMCIA, EISA, ISA)\n"
 	"      -> PCI support (PCI [=y])\n"
 	"(1)     -> PCI access mode (<choice> [=y])\n"
+	"  Defined at drivers/pci/Kconfig:47\n"
+	"  Depends on: X86_LOCAL_APIC && X86_IO_APIC || IA64\n"
 	"  Selects: LIBCRC32\n"
-	"  Selected by: BAR\n"
+	"  Selected by: BAR [=n]\n"
 	"-----------------------------------------------------------------\n"
 	"o The line 'Type:' shows the type of the configuration option for\n"
 	"  this symbol (boolean, tristate, string, ...)\n"
 	"o The line 'Prompt:' shows the text used in the menu structure for\n"
 	"  this symbol\n"
-	"o The 'Defined at' line tell at what file / line number the symbol\n"
+	"o The 'Defined at' line tells at what file / line number the symbol\n"
 	"  is defined\n"
-	"o The 'Depends on:' line tell what symbols needs to be defined for\n"
+	"o The 'Depends on:' line tells what symbols need to be defined for\n"
 	"  this symbol to be visible in the menu (selectable)\n"
-	"o The 'Location:' lines tell where in the menu structure this symbol\n"
+	"o The 'Location:' lines tells where in the menu structure this symbol\n"
 	"  is located\n"
 	"    A location followed by a [=y] indicates that this is a\n"
 	"    selectable menu item - and the current value is displayed inside\n"
@@ -263,9 +261,9 @@ search_help[] = N_(
 	"    Press the key in the (#) prefix to jump directly to that\n"
 	"    location. You will be returned to the current search results\n"
 	"    after exiting this new menu.\n"
-	"o The 'Selects:' line tell what symbol will be automatically\n"
+	"o The 'Selects:' line tells what symbols will be automatically\n"
 	"  selected if this symbol is selected (y or m)\n"
-	"o The 'Selected by' line tell what symbol has selected this symbol\n"
+	"o The 'Selected by' line tells what symbol has selected this symbol\n"
 	"\n"
 	"Only relevant lines are shown.\n"
 	"\n\n"
@@ -281,6 +279,7 @@ static int child_count;
 static int single_menu_mode;
 static int show_all_options;
 static int save_and_exit;
+static int silent;
 
 static void conf(struct menu *menu, struct menu *active_menu);
 static void conf_choice(struct menu *menu);
@@ -301,7 +300,7 @@ static void set_config_filename(const char *config_filename)
 	int size;
 
 	size = snprintf(menu_backtitle, sizeof(menu_backtitle),
-	                "%s - %s", config_filename, rootmenu.prompt->text);
+			"%s - %s", config_filename, rootmenu.prompt->text);
 	if (size >= sizeof(menu_backtitle))
 		menu_backtitle[sizeof(menu_backtitle)-1] = '\0';
 	set_dialog_backtitle(menu_backtitle);
@@ -311,6 +310,50 @@ static void set_config_filename(const char *config_filename)
 		filename[sizeof(filename)-1] = '\0';
 }
 
+struct subtitle_part {
+	struct list_head entries;
+	const char *text;
+};
+static LIST_HEAD(trail);
+
+static struct subtitle_list *subtitles;
+static void set_subtitle(void)
+{
+	struct subtitle_part *sp;
+	struct subtitle_list *pos, *tmp;
+
+	for (pos = subtitles; pos != NULL; pos = tmp) {
+		tmp = pos->next;
+		free(pos);
+	}
+
+	subtitles = NULL;
+	list_for_each_entry(sp, &trail, entries) {
+		if (sp->text) {
+			if (pos) {
+				pos->next = xcalloc(1, sizeof(*pos));
+				pos = pos->next;
+			} else {
+				subtitles = pos = xcalloc(1, sizeof(*pos));
+			}
+			pos->text = sp->text;
+		}
+	}
+
+	set_dialog_subtitles(subtitles);
+}
+
+static void reset_subtitle(void)
+{
+	struct subtitle_list *pos, *tmp;
+
+	for (pos = subtitles; pos != NULL; pos = tmp) {
+		tmp = pos->next;
+		free(pos);
+	}
+	subtitles = NULL;
+	set_dialog_subtitles(subtitles);
+}
 
 struct search_data {
 	struct list_head *head;
@@ -353,10 +396,12 @@ static void search_conf(void)
 	char *dialog_input;
 	int dres, vscroll = 0, hscroll = 0;
 	bool again;
+	struct gstr sttext;
+	struct subtitle_part stpart;
 
 	title = str_new();
-	str_printf( &title, _("Enter %s (sub)string to search for "
-			      "(with or without \"%s\")"), CONFIG_, CONFIG_);
+	str_printf( &title, _("Enter (sub)string or regexp to search for "
+			      "(with or without \"%s\")"), CONFIG_);
 
 again:
 	dialog_clear();
@@ -379,6 +424,11 @@ again:
 	if (strncasecmp(dialog_input_result, CONFIG_, strlen(CONFIG_)) == 0)
 		dialog_input += strlen(CONFIG_);
 
+	sttext = str_new();
+	str_printf(&sttext, "Search (%s)", dialog_input_result);
+	stpart.text = str_get(&sttext);
+	list_add_tail(&stpart.entries, &trail);
+
 	sym_arr = sym_re_search(dialog_input);
 	do {
 		LIST_HEAD(head);
@@ -389,8 +439,10 @@ again:
 			.targets = targets,
 			.keys = keys,
 		};
+		struct jump_key *pos, *tmp;
 
 		res = get_relations_str(sym_arr, &head);
+		set_subtitle();
 		dres = show_textbox_ext(_("Search Results"), (char *)
 					str_get(&res), 0, 0, keys, &vscroll,
 					&hscroll, &update_text, (void *)
@@ -402,9 +454,13 @@ again:
 				again = true;
 			}
 		str_free(&res);
+		list_for_each_entry_safe(pos, tmp, &head, entries)
+			free(pos);
 	} while (again);
 	free(sym_arr);
 	str_free(&title);
+	list_del(trail.prev);
+	str_free(&sttext);
 }
 
 static void build_conf(struct menu *menu)
@@ -441,8 +497,9 @@ static void build_conf(struct menu *menu)
 						  menu->data ? "-->" : "++>",
 						  indent + 1, ' ', prompt);
 				} else
-					item_make("   %*c%s  --->", indent + 1, ' ', prompt);
-
+					item_make("   %*c%s  %s",
+						  indent + 1, ' ', prompt,
+						  menu_is_empty(menu) ? "----" : "--->");
 				item_set_tag('m');
 				item_set_data(menu);
 				if (single_menu_mode && menu->data)
@@ -573,7 +630,7 @@ static void build_conf(struct menu *menu)
 			  (sym_has_value(sym) || !sym_is_changable(sym)) ?
 			  "" : _(" (NEW)"));
 		if (menu->prompt->type == P_MENU) {
-			item_add_str("  --->");
+			item_add_str("  %s", menu_is_empty(menu) ? "----" : "--->");
 			return;
 		}
 	}
@@ -589,27 +646,36 @@ static void conf(struct menu *menu, struct menu *active_menu)
 {
 	struct menu *submenu;
 	const char *prompt = menu_get_prompt(menu);
+	struct subtitle_part stpart;
 	struct symbol *sym;
 	int res;
 	int s_scroll = 0;
 
+	if (menu != &rootmenu)
+		stpart.text = menu_get_prompt(menu);
+	else
+		stpart.text = NULL;
+	list_add_tail(&stpart.entries, &trail);
+
 	while (1) {
 		item_reset();
 		current_menu = menu;
 		build_conf(menu);
 		if (!child_count)
 			break;
+		set_subtitle();
 		dialog_clear();
 		res = dialog_menu(prompt ? _(prompt) : _("Main Menu"),
 				  _(menu_instructions),
 				  active_menu, &s_scroll);
 		if (res == 1 || res == KEY_ESC || res == -ERRDISPLAYTOOSMALL)
 			break;
-		if (!item_activate_selected())
-			continue;
-		if (!item_tag())
-			continue;
-
+		if (item_count() != 0) {
+			if (!item_activate_selected())
+				continue;
+			if (!item_tag())
+				continue;
+		}
 		submenu = item_data();
 		active_menu = item_data();
 		if (submenu)
@@ -640,13 +706,17 @@ static void conf(struct menu *menu, struct menu *active_menu)
 		case 2:
 			if (sym)
 				show_help(submenu);
-			else
+			else {
+				reset_subtitle();
 				show_helptext(_("README"), _(mconf_readme));
+			}
 			break;
 		case 3:
+			reset_subtitle();
 			conf_save();
 			break;
 		case 4:
+			reset_subtitle();
 			conf_load();
 			break;
 		case 5:
@@ -679,6 +749,8 @@ static void conf(struct menu *menu, struct menu *active_menu)
 			break;
 		}
 	}
+
+	list_del(trail.prev);
 }
 
 static int show_textbox_ext(const char *title, char *text, int r, int c, int
@@ -706,10 +778,12 @@ static void conf_message_callback(const char *fmt, va_list ap)
 	char buf[PATH_MAX+1];
 
 	vsnprintf(buf, sizeof(buf), fmt, ap);
-	if (save_and_exit)
-		printf("%s", buf);
-	else
+	if (save_and_exit) {
+		if (!silent)
+			printf("%s", buf);
+	} else {
 		show_textbox(NULL, buf, 6, 60);
+	}
 }
 
 static void show_help(struct menu *menu)
@@ -754,7 +828,9 @@ static void conf_choice(struct menu *menu)
 		dialog_clear();
 		res = dialog_checklist(prompt ? _(prompt) : _("Main Menu"),
 					_(radiolist_instructions),
-					 15, 70, 6);
+					MENUBOX_HEIGTH_MIN,
+					MENUBOX_WIDTH_MIN,
+					CHECKLIST_HEIGTH_MIN);
 		selected = item_activate_selected();
 		switch (res) {
 		case 0:
@@ -881,11 +957,12 @@ static int handle_exit(void)
 	int res;
 
 	save_and_exit = 1;
+	reset_subtitle();
 	dialog_clear();
 	if (conf_get_changed())
 		res = dialog_yesno(NULL,
-				   _("Do you wish to save your new configuration ?\n"
-				     "<ESC><ESC> to continue."),
+				   _("Do you wish to save your new configuration?\n"
+				     "(Press <ESC><ESC> to continue kernel configuration.)"),
 				   6, 60);
 	else
 		res = -1;
@@ -903,16 +980,18 @@ static int handle_exit(void)
 		}
 		/* fall through */
 	case -1:
-		printf(_("\n\n"
-			 "*** End of the configuration.\n"
-			 "*** Execute 'make' to start the build or try 'make help'."
-			 "\n\n"));
+		if (!silent)
+			printf(_("\n\n"
+				 "*** End of the configuration.\n"
+				 "*** Execute 'make' to start the build or try 'make help'."
+				 "\n\n"));
 		res = 0;
 		break;
 	default:
-		fprintf(stderr, _("\n\n"
-				  "Your configuration changes were NOT saved."
-				  "\n\n"));
+		if (!silent)
+			fprintf(stderr, _("\n\n"
+					  "Your configuration changes were NOT saved."
+					  "\n\n"));
 		if (res != KEY_ESC)
 			res = 0;
 	}
@@ -936,6 +1015,12 @@ int main(int ac, char **av)
 
 	signal(SIGINT, sig_handler);
 
+	if (ac > 1 && strcmp(av[1], "-s") == 0) {
+		silent = 1;
+		/* Silence conf_read() until the real callback is set up */
+		conf_set_message_callback(NULL);
+		av++;
+	}
 	conf_parse(av[1]);
 	conf_read(NULL);
 
@@ -960,4 +1045,3 @@ int main(int ac, char **av)
 
 	return res;
 }
-
diff --git a/backport/kconf/menu.c b/backport/kconf/menu.c
index f3bffa309333..b05cc3d4a9be 100644
--- a/backport/kconf/menu.c
+++ b/backport/kconf/menu.c
@@ -119,12 +119,13 @@ void menu_set_type(int type)
 		sym->type = type;
 		return;
 	}
-	menu_warn(current_entry, "type of '%s' redefined from '%s' to '%s'",
-	    sym->name ? sym->name : "<choice>",
-	    sym_type_name(sym->type), sym_type_name(type));
+	menu_warn(current_entry,
+		"ignoring type redefinition of '%s' from '%s' to '%s'",
+		sym->name ? sym->name : "<choice>",
+		sym_type_name(sym->type), sym_type_name(type));
 }
 
-struct property *menu_add_prop(enum prop_type type, char *prompt, struct expr *expr, struct expr *dep)
+static struct property *menu_add_prop(enum prop_type type, char *prompt, struct expr *expr, struct expr *dep)
 {
 	struct property *prop = prop_alloc(type, current_entry->sym);
 
@@ -146,11 +147,24 @@ struct property *menu_add_prop(enum prop_type type, char *prompt, struct expr *e
 			struct menu *menu = current_entry;
 
 			while ((menu = menu->parent) != NULL) {
+				struct expr *dup_expr;
+
 				if (!menu->visibility)
 					continue;
+				/*
+				 * Do not add a reference to the
+				 * menu's visibility expression but
+				 * use a copy of it.  Otherwise the
+				 * expression reduction functions
+				 * will modify expressions that have
+				 * multiple references which can
+				 * cause unwanted side effects.
+				 */
+				dup_expr = expr_copy(menu->visibility);
+
 				prop->visible.expr
 					= expr_alloc_and(prop->visible.expr,
-							 menu->visibility);
+							 dup_expr);
 			}
 		}
 
@@ -184,12 +198,15 @@ void menu_add_symbol(enum prop_type type, struct symbol *sym, struct expr *dep)
 
 void menu_add_option(int token, char *arg)
 {
-	struct property *prop;
-
 	switch (token) {
 	case T_OPT_MODULES:
-		prop = prop_alloc(P_DEFAULT, modules_sym);
-		prop->expr = expr_alloc_symbol(current_entry->sym);
+		if (modules_sym)
+			zconf_error("symbol '%s' redefines option 'modules'"
+				    " already defined by symbol '%s'",
+				    current_entry->sym->name,
+				    modules_sym->name
+				    );
+		modules_sym = current_entry->sym;
 		break;
 	case T_OPT_DEFCONFIG_LIST:
 		if (!sym_defconfig_list)
@@ -200,6 +217,9 @@ void menu_add_option(int token, char *arg)
 	case T_OPT_ENV:
 		prop_add_env(arg);
 		break;
+	case T_OPT_ALLNOCONFIG_Y:
+		current_entry->sym->flags |= SYMBOL_ALLNOCONFIG_Y;
+		break;
 	}
 }
 
@@ -238,8 +258,8 @@ static void sym_check_prop(struct symbol *sym)
 				    "config symbol '%s' uses select, but is "
 				    "not boolean or tristate", sym->name);
 			else if (sym2->type != S_UNKNOWN &&
-			         sym2->type != S_BOOLEAN &&
-			         sym2->type != S_TRISTATE)
+				 sym2->type != S_BOOLEAN &&
+				 sym2->type != S_TRISTATE)
 				prop_warn(prop,
 				    "'%s' has wrong type. 'select' only "
 				    "accept arguments of boolean and "
@@ -248,7 +268,7 @@ static void sym_check_prop(struct symbol *sym)
 		case P_RANGE:
 			if (sym->type != S_INT && sym->type != S_HEX)
 				prop_warn(prop, "range is only allowed "
-				                "for int or hex symbols");
+						"for int or hex symbols");
 			if (!menu_validate_number(sym, prop->expr->left.sym) ||
 			    !menu_validate_number(sym, prop->expr->right.sym))
 				prop_warn(prop, "range is invalid");
@@ -430,6 +450,22 @@ bool menu_has_prompt(struct menu *menu)
 	return true;
 }
 
+/*
+ * Determine if a menu is empty.
+ * A menu is considered empty if it contains no or only
+ * invisible entries.
+ */
+bool menu_is_empty(struct menu *menu)
+{
+	struct menu *child;
+
+	for (child = menu->list; child; child = child->next) {
+		if (menu_is_visible(child))
+			return(false);
+	}
+	return(true);
+}
+
 bool menu_is_visible(struct menu *menu)
 {
 	struct menu *child;
@@ -512,16 +548,9 @@ static void get_prompt_str(struct gstr *r, struct property *prop,
 {
 	int i, j;
 	struct menu *submenu[8], *menu, *location = NULL;
-	struct jump_key *jump;
+	struct jump_key *jump = NULL;
 
 	str_printf(r, _("Prompt: %s\n"), _(prop->text));
-	str_printf(r, _("  Defined at %s:%d\n"), prop->menu->file->name,
-		prop->menu->lineno);
-	if (!expr_is_yes(prop->visible.expr)) {
-		str_append(r, _("  Depends on: "));
-		expr_gstr_print(prop->visible.expr, r);
-		str_append(r, "\n");
-	}
 	menu = prop->menu->parent;
 	for (i = 0; menu != &rootmenu && i < 8; menu = menu->parent) {
 		bool accessible = menu_is_visible(menu);
@@ -557,8 +586,8 @@ static void get_prompt_str(struct gstr *r, struct property *prop,
 		str_printf(r, _("  Location:\n"));
 		for (j = 4; --i >= 0; j += 2) {
 			menu = submenu[i];
-			if (head && location && menu == location)
-				jump->offset = r->len - 1;
+			if (jump && menu == location)
+				jump->offset = strlen(r->s);
 			str_printf(r, "%*c-> %s", j, ' ',
 				   _(menu_get_prompt(menu)));
 			if (menu->sym) {
@@ -572,9 +601,21 @@ static void get_prompt_str(struct gstr *r, struct property *prop,
 }
 
 /*
+ * get property of type P_SYMBOL
+ */
+static struct property *get_symbol_prop(struct symbol *sym)
+{
+	struct property *prop = NULL;
+
+	for_all_properties(sym, prop, P_SYMBOL)
+		break;
+	return prop;
+}
+
+/*
  * head is optional and may be NULL
  */
-void get_symbol_str(struct gstr *r, struct symbol *sym,
+static void get_symbol_str(struct gstr *r, struct symbol *sym,
 		    struct list_head *head)
 {
 	bool hit;
@@ -595,6 +636,18 @@ void get_symbol_str(struct gstr *r, struct symbol *sym,
 	}
 	for_all_prompts(sym, prop)
 		get_prompt_str(r, prop, head);
+
+	prop = get_symbol_prop(sym);
+	if (prop) {
+		str_printf(r, _("  Defined at %s:%d\n"), prop->menu->file->name,
+			prop->menu->lineno);
+		if (!expr_is_yes(prop->visible.expr)) {
+			str_append(r, _("  Depends on: "));
+			expr_gstr_print(prop->visible.expr, r);
+			str_append(r, "\n");
+		}
+	}
+
 	hit = false;
 	for_all_properties(sym, prop, P_SELECT) {
 		if (!hit) {
diff --git a/backport/kconf/symbol.c b/backport/kconf/symbol.c
index ecc5aa5f865d..70c5ee189dce 100644
--- a/backport/kconf/symbol.c
+++ b/backport/kconf/symbol.c
@@ -112,7 +112,7 @@ struct property *sym_get_env_prop(struct symbol *sym)
 	return NULL;
 }
 
-struct property *sym_get_default_prop(struct symbol *sym)
+static struct property *sym_get_default_prop(struct symbol *sym)
 {
 	struct property *prop;
 
@@ -136,7 +136,7 @@ static struct property *sym_get_range_prop(struct symbol *sym)
 	return NULL;
 }
 
-static int sym_get_range_val(struct symbol *sym, int base)
+static long long sym_get_range_val(struct symbol *sym, int base)
 {
 	sym_calc_value(sym);
 	switch (sym->type) {
@@ -149,13 +149,14 @@ static int sym_get_range_val(struct symbol *sym, int base)
 	default:
 		break;
 	}
-	return strtol(sym->curr.val, NULL, base);
+	return strtoll(sym->curr.val, NULL, base);
 }
 
 static void sym_validate_range(struct symbol *sym)
 {
 	struct property *prop;
-	int base, val, val2;
+	int base;
+	long long val, val2;
 	char str[64];
 
 	switch (sym->type) {
@@ -171,7 +172,7 @@ static void sym_validate_range(struct symbol *sym)
 	prop = sym_get_range_prop(sym);
 	if (!prop)
 		return;
-	val = strtol(sym->curr.val, NULL, base);
+	val = strtoll(sym->curr.val, NULL, base);
 	val2 = sym_get_range_val(prop->expr->left.sym, base);
 	if (val >= val2) {
 		val2 = sym_get_range_val(prop->expr->right.sym, base);
@@ -179,12 +180,32 @@ static void sym_validate_range(struct symbol *sym)
 			return;
 	}
 	if (sym->type == S_INT)
-		sprintf(str, "%d", val2);
+		sprintf(str, "%lld", val2);
 	else
-		sprintf(str, "0x%x", val2);
+		sprintf(str, "0x%llx", val2);
 	sym->curr.val = strdup(str);
 }
 
+static void sym_set_changed(struct symbol *sym)
+{
+	struct property *prop;
+
+	sym->flags |= SYMBOL_CHANGED;
+	for (prop = sym->prop; prop; prop = prop->next) {
+		if (prop->menu)
+			prop->menu->flags |= MENU_CHANGED;
+	}
+}
+
+static void sym_set_all_changed(void)
+{
+	struct symbol *sym;
+	int i;
+
+	for_all_symbols(i, sym)
+		sym_set_changed(sym);
+}
+
 static void sym_calc_visibility(struct symbol *sym)
 {
 	struct property *prop;
@@ -300,6 +321,14 @@ void sym_calc_value(struct symbol *sym)
 
 	if (sym->flags & SYMBOL_VALID)
 		return;
+
+	if (sym_is_choice_value(sym) &&
+	    sym->flags & SYMBOL_NEED_SET_CHOICE_VALUES) {
+		sym->flags &= ~SYMBOL_NEED_SET_CHOICE_VALUES;
+		prop = sym_get_choice_prop(sym);
+		sym_calc_value(prop_get_symbol(prop));
+	}
+
 	sym->flags |= SYMBOL_VALID;
 
 	oldval = sym->curr;
@@ -425,6 +454,9 @@ void sym_calc_value(struct symbol *sym)
 
 	if (sym->flags & SYMBOL_AUTO)
 		sym->flags &= ~SYMBOL_WRITE;
+
+	if (sym->flags & SYMBOL_NEED_SET_CHOICE_VALUES)
+		set_all_choice_values(sym);
 }
 
 void sym_clear_all_valid(void)
@@ -439,26 +471,6 @@ void sym_clear_all_valid(void)
 		sym_calc_value(modules_sym);
 }
 
-void sym_set_changed(struct symbol *sym)
-{
-	struct property *prop;
-
-	sym->flags |= SYMBOL_CHANGED;
-	for (prop = sym->prop; prop; prop = prop->next) {
-		if (prop->menu)
-			prop->menu->flags |= MENU_CHANGED;
-	}
-}
-
-void sym_set_all_changed(void)
-{
-	struct symbol *sym;
-	int i;
-
-	for_all_symbols(i, sym)
-		sym_set_changed(sym);
-}
-
 bool sym_tristate_within_range(struct symbol *sym, tristate val)
 {
 	int type = sym_get_type(sym);
@@ -583,7 +595,7 @@ bool sym_string_valid(struct symbol *sym, const char *str)
 bool sym_string_within_range(struct symbol *sym, const char *str)
 {
 	struct property *prop;
-	int val;
+	long long val;
 
 	switch (sym->type) {
 	case S_STRING:
@@ -594,7 +606,7 @@ bool sym_string_within_range(struct symbol *sym, const char *str)
 		prop = sym_get_range_prop(sym);
 		if (!prop)
 			return true;
-		val = strtol(str, NULL, 10);
+		val = strtoll(str, NULL, 10);
 		return val >= sym_get_range_val(prop->expr->left.sym, 10) &&
 		       val <= sym_get_range_val(prop->expr->right.sym, 10);
 	case S_HEX:
@@ -603,7 +615,7 @@ bool sym_string_within_range(struct symbol *sym, const char *str)
 		prop = sym_get_range_prop(sym);
 		if (!prop)
 			return true;
-		val = strtol(str, NULL, 16);
+		val = strtoll(str, NULL, 16);
 		return val >= sym_get_range_val(prop->expr->left.sym, 16) &&
 		       val <= sym_get_range_val(prop->expr->right.sym, 16);
 	case S_BOOLEAN:
@@ -943,38 +955,89 @@ const char *sym_escape_string_value(const char *in)
 	return res;
 }
 
+struct sym_match {
+	struct symbol	*sym;
+	off_t		so, eo;
+};
+
+/* Compare matched symbols as thus:
+ * - first, symbols that match exactly
+ * - then, alphabetical sort
+ */
+static int sym_rel_comp(const void *sym1, const void *sym2)
+{
+	const struct sym_match *s1 = sym1;
+	const struct sym_match *s2 = sym2;
+	int exact1, exact2;
+
+	/* Exact match:
+	 * - if matched length on symbol s1 is the length of that symbol,
+	 *   then this symbol should come first;
+	 * - if matched length on symbol s2 is the length of that symbol,
+	 *   then this symbol should come first.
+	 * Note: since the search can be a regexp, both symbols may match
+	 * exactly; if this is the case, we can't decide which comes first,
+	 * and we fallback to sorting alphabetically.
+	 */
+	exact1 = (s1->eo - s1->so) == strlen(s1->sym->name);
+	exact2 = (s2->eo - s2->so) == strlen(s2->sym->name);
+	if (exact1 && !exact2)
+		return -1;
+	if (!exact1 && exact2)
+		return 1;
+
+	/* As a fallback, sort symbols alphabetically */
+	return strcmp(s1->sym->name, s2->sym->name);
+}
+
 struct symbol **sym_re_search(const char *pattern)
 {
 	struct symbol *sym, **sym_arr = NULL;
+	struct sym_match *sym_match_arr = NULL;
 	int i, cnt, size;
 	regex_t re;
+	regmatch_t match[1];
 
 	cnt = size = 0;
 	/* Skip if empty */
 	if (strlen(pattern) == 0)
 		return NULL;
-	if (regcomp(&re, pattern, REG_EXTENDED|REG_NOSUB|REG_ICASE))
+	if (regcomp(&re, pattern, REG_EXTENDED|REG_ICASE))
 		return NULL;
 
 	for_all_symbols(i, sym) {
 		if (sym->flags & SYMBOL_CONST || !sym->name)
 			continue;
-		if (regexec(&re, sym->name, 0, NULL, 0))
+		if (regexec(&re, sym->name, 1, match, 0))
 			continue;
-		if (cnt + 1 >= size) {
-			void *tmp = sym_arr;
+		if (cnt >= size) {
+			void *tmp;
 			size += 16;
-			sym_arr = realloc(sym_arr, size * sizeof(struct symbol *));
-			if (!sym_arr) {
-				free(tmp);
-				return NULL;
-			}
+			tmp = realloc(sym_match_arr, size * sizeof(struct sym_match));
+			if (!tmp)
+				goto sym_re_search_free;
+			sym_match_arr = tmp;
 		}
 		sym_calc_value(sym);
-		sym_arr[cnt++] = sym;
+		/* As regexec returned 0, we know we have a match, so
+		 * we can use match[0].rm_[se]o without further checks
+		 */
+		sym_match_arr[cnt].so = match[0].rm_so;
+		sym_match_arr[cnt].eo = match[0].rm_eo;
+		sym_match_arr[cnt++].sym = sym;
 	}
-	if (sym_arr)
+	if (sym_match_arr) {
+		qsort(sym_match_arr, cnt, sizeof(struct sym_match), sym_rel_comp);
+		sym_arr = malloc((cnt+1) * sizeof(struct symbol));
+		if (!sym_arr)
+			goto sym_re_search_free;
+		for (i = 0; i < cnt; i++)
+			sym_arr[i] = sym_match_arr[i].sym;
 		sym_arr[cnt] = NULL;
+	}
+sym_re_search_free:
+	/* sym_match_arr can be NULL if no match, but free(NULL) is OK */
+	free(sym_match_arr);
 	regfree(&re);
 
 	return sym_arr;
@@ -984,7 +1047,7 @@ struct symbol **sym_re_search(const char *pattern)
  * When we check for recursive dependencies we use a stack to save
  * current state so we can print out relevant info to user.
  * The entries are located on the call stack so no need to free memory.
- * Note inser() remove() must always match to properly clear the stack.
+ * Note insert() remove() must always match to properly clear the stack.
  */
 static struct dep_stack {
 	struct dep_stack *prev, *next;
@@ -1103,6 +1166,10 @@ static struct symbol *sym_check_expr_deps(struct expr *e)
 	case E_NOT:
 		return sym_check_expr_deps(e->left.expr);
 	case E_EQUAL:
+	case E_GEQ:
+	case E_GTH:
+	case E_LEQ:
+	case E_LTH:
 	case E_UNEQUAL:
 		sym = sym_check_deps(e->left.sym);
 		if (sym)
diff --git a/backport/kconf/util.c b/backport/kconf/util.c
index 6e7fbf196809..0e76042473cc 100644
--- a/backport/kconf/util.c
+++ b/backport/kconf/util.c
@@ -88,16 +88,6 @@ struct gstr str_new(void)
 	return gs;
 }
 
-/* Allocate and assign growable string */
-struct gstr str_assign(const char *s)
-{
-	struct gstr gs;
-	gs.s = strdup(s);
-	gs.len = strlen(s) + 1;
-	gs.max_width = 0;
-	return gs;
-}
-
 /* Free storage for growable string */
 void str_free(struct gstr *gs)
 {
@@ -155,5 +145,3 @@ void *xcalloc(size_t nmemb, size_t size)
 	fprintf(stderr, "Out of memory.\n");
 	exit(1);
 }
-
-
diff --git a/backport/kconf/zconf.hash.c b/backport/kconf/zconf.hash.c
index 40df0005daa9..c77a8eff1ef2 100644
--- a/backport/kconf/zconf.hash.c
+++ b/backport/kconf/zconf.hash.c
@@ -55,10 +55,10 @@ kconf_id_hash (register const char *str, register unsigned int len)
       73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
       73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
       73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 25, 25,
+      73, 73, 73, 73, 73, 73, 73,  5, 25, 25,
        0,  0,  0,  5,  0,  0, 73, 73,  5,  0,
       10,  5, 45, 73, 20, 20,  0, 15, 15, 73,
-      20, 73, 73, 73, 73, 73, 73, 73, 73, 73,
+      20,  5, 73, 73, 73, 73, 73, 73, 73, 73,
       73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
       73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
       73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
@@ -106,6 +106,7 @@ struct kconf_id_strings_t
     char kconf_id_strings_str23[sizeof("mainmenu")];
     char kconf_id_strings_str25[sizeof("menuconfig")];
     char kconf_id_strings_str27[sizeof("modules")];
+    char kconf_id_strings_str28[sizeof("allnoconfig_y")];
     char kconf_id_strings_str29[sizeof("menu")];
     char kconf_id_strings_str31[sizeof("select")];
     char kconf_id_strings_str32[sizeof("comment")];
@@ -141,6 +142,7 @@ static const struct kconf_id_strings_t kconf_id_strings_contents =
     "mainmenu",
     "menuconfig",
     "modules",
+    "allnoconfig_y",
     "menu",
     "select",
     "comment",
@@ -170,7 +172,7 @@ kconf_id_lookup (register const char *str, register unsigned int len)
 {
   enum
     {
-      TOTAL_KEYWORDS = 32,
+      TOTAL_KEYWORDS = 33,
       MIN_WORD_LENGTH = 2,
       MAX_WORD_LENGTH = 14,
       MIN_HASH_VALUE = 2,
@@ -219,7 +221,8 @@ kconf_id_lookup (register const char *str, register unsigned int len)
       {-1},
 #line 44 "scripts/kconfig/zconf.gperf"
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str27,	T_OPT_MODULES,	TF_OPTION},
-      {-1},
+#line 47 "scripts/kconfig/zconf.gperf"
+      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str28,	T_OPT_ALLNOCONFIG_Y,TF_OPTION},
 #line 16 "scripts/kconfig/zconf.gperf"
       {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str29,		T_MENU,		TF_COMMAND},
       {-1},
@@ -282,5 +285,5 @@ kconf_id_lookup (register const char *str, register unsigned int len)
     }
   return 0;
 }
-#line 47 "scripts/kconfig/zconf.gperf"
+#line 48 "scripts/kconfig/zconf.gperf"
 
diff --git a/backport/kconf/zconf.lex.c b/backport/kconf/zconf.lex.c
index a0521aa5974b..dd4e86c82521 100644
--- a/backport/kconf/zconf.lex.c
+++ b/backport/kconf/zconf.lex.c
@@ -365,323 +365,354 @@ int zconflineno = 1;
 
 extern char *zconftext;
 #define yytext_ptr zconftext
-static yyconst flex_int16_t yy_nxt[][17] =
+static yyconst flex_int16_t yy_nxt[][19] =
     {
     {
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
-        0,    0,    0,    0,    0,    0,    0
+        0,    0,    0,    0,    0,    0,    0,    0,    0
     },
 
     {
        11,   12,   13,   14,   12,   12,   15,   12,   12,   12,
-       12,   12,   12,   12,   12,   12,   12
+       12,   12,   12,   12,   12,   12,   12,   12,   12
     },
 
     {
        11,   12,   13,   14,   12,   12,   15,   12,   12,   12,
-       12,   12,   12,   12,   12,   12,   12
+       12,   12,   12,   12,   12,   12,   12,   12,   12
     },
 
     {
        11,   16,   16,   17,   16,   16,   16,   16,   16,   16,
-       16,   16,   16,   18,   16,   16,   16
+       16,   16,   16,   18,   16,   16,   16,   16,   16
     },
 
     {
        11,   16,   16,   17,   16,   16,   16,   16,   16,   16,
-       16,   16,   16,   18,   16,   16,   16
+       16,   16,   16,   18,   16,   16,   16,   16,   16
 
     },
 
     {
        11,   19,   20,   21,   19,   19,   19,   19,   19,   19,
-       19,   19,   19,   19,   19,   19,   19
+       19,   19,   19,   19,   19,   19,   19,   19,   19
     },
 
     {
        11,   19,   20,   21,   19,   19,   19,   19,   19,   19,
-       19,   19,   19,   19,   19,   19,   19
+       19,   19,   19,   19,   19,   19,   19,   19,   19
     },
 
     {
        11,   22,   22,   23,   22,   24,   22,   22,   24,   22,
-       22,   22,   22,   22,   22,   25,   22
+       22,   22,   22,   22,   22,   22,   22,   25,   22
     },
 
     {
        11,   22,   22,   23,   22,   24,   22,   22,   24,   22,
-       22,   22,   22,   22,   22,   25,   22
+       22,   22,   22,   22,   22,   22,   22,   25,   22
     },
 
     {
-       11,   26,   26,   27,   28,   29,   30,   31,   29,   32,
-       33,   34,   35,   35,   36,   37,   38
+       11,   26,   27,   28,   29,   30,   31,   32,   30,   33,
+       34,   35,   36,   36,   37,   38,   39,   40,   41
 
     },
 
     {
-       11,   26,   26,   27,   28,   29,   30,   31,   29,   32,
-       33,   34,   35,   35,   36,   37,   38
+       11,   26,   27,   28,   29,   30,   31,   32,   30,   33,
+       34,   35,   36,   36,   37,   38,   39,   40,   41
     },
 
     {
       -11,  -11,  -11,  -11,  -11,  -11,  -11,  -11,  -11,  -11,
-      -11,  -11,  -11,  -11,  -11,  -11,  -11
+      -11,  -11,  -11,  -11,  -11,  -11,  -11,  -11,  -11
     },
 
     {
        11,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
-      -12,  -12,  -12,  -12,  -12,  -12,  -12
+      -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12
     },
 
     {
-       11,  -13,   39,   40,  -13,  -13,   41,  -13,  -13,  -13,
-      -13,  -13,  -13,  -13,  -13,  -13,  -13
+       11,  -13,   42,   43,  -13,  -13,   44,  -13,  -13,  -13,
+      -13,  -13,  -13,  -13,  -13,  -13,  -13,  -13,  -13
     },
 
     {
        11,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
-      -14,  -14,  -14,  -14,  -14,  -14,  -14
+      -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14
 
     },
 
     {
-       11,   42,   42,   43,   42,   42,   42,   42,   42,   42,
-       42,   42,   42,   42,   42,   42,   42
+       11,   45,   45,   46,   45,   45,   45,   45,   45,   45,
+       45,   45,   45,   45,   45,   45,   45,   45,   45
     },
 
     {
        11,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
-      -16,  -16,  -16,  -16,  -16,  -16,  -16
+      -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16
     },
 
     {
        11,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
-      -17,  -17,  -17,  -17,  -17,  -17,  -17
+      -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17
     },
 
     {
        11,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
-      -18,  -18,  -18,   44,  -18,  -18,  -18
+      -18,  -18,  -18,   47,  -18,  -18,  -18,  -18,  -18
     },
 
     {
-       11,   45,   45,  -19,   45,   45,   45,   45,   45,   45,
-       45,   45,   45,   45,   45,   45,   45
+       11,   48,   48,  -19,   48,   48,   48,   48,   48,   48,
+       48,   48,   48,   48,   48,   48,   48,   48,   48
 
     },
 
     {
-       11,  -20,   46,   47,  -20,  -20,  -20,  -20,  -20,  -20,
-      -20,  -20,  -20,  -20,  -20,  -20,  -20
+       11,  -20,   49,   50,  -20,  -20,  -20,  -20,  -20,  -20,
+      -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20
     },
 
     {
-       11,   48,  -21,  -21,   48,   48,   48,   48,   48,   48,
-       48,   48,   48,   48,   48,   48,   48
+       11,   51,  -21,  -21,   51,   51,   51,   51,   51,   51,
+       51,   51,   51,   51,   51,   51,   51,   51,   51
     },
 
     {
-       11,   49,   49,   50,   49,  -22,   49,   49,  -22,   49,
-       49,   49,   49,   49,   49,  -22,   49
+       11,   52,   52,   53,   52,  -22,   52,   52,  -22,   52,
+       52,   52,   52,   52,   52,   52,   52,  -22,   52
     },
 
     {
        11,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
-      -23,  -23,  -23,  -23,  -23,  -23,  -23
+      -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23
     },
 
     {
        11,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
-      -24,  -24,  -24,  -24,  -24,  -24,  -24
+      -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24
 
     },
 
     {
-       11,   51,   51,   52,   51,   51,   51,   51,   51,   51,
-       51,   51,   51,   51,   51,   51,   51
+       11,   54,   54,   55,   54,   54,   54,   54,   54,   54,
+       54,   54,   54,   54,   54,   54,   54,   54,   54
     },
 
     {
        11,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
-      -26,  -26,  -26,  -26,  -26,  -26,  -26
+      -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26
     },
 
     {
-       11,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
-      -27,  -27,  -27,  -27,  -27,  -27,  -27
+       11,  -27,   56,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
+      -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27
     },
 
     {
        11,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
-      -28,  -28,  -28,  -28,   53,  -28,  -28
+      -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28
     },
 
     {
        11,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
-      -29,  -29,  -29,  -29,  -29,  -29,  -29
+      -29,  -29,  -29,  -29,  -29,   57,  -29,  -29,  -29
 
     },
 
     {
-       11,   54,   54,  -30,   54,   54,   54,   54,   54,   54,
-       54,   54,   54,   54,   54,   54,   54
+       11,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,
+      -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30
     },
 
     {
-       11,  -31,  -31,  -31,  -31,  -31,  -31,   55,  -31,  -31,
-      -31,  -31,  -31,  -31,  -31,  -31,  -31
+       11,   58,   58,  -31,   58,   58,   58,   58,   58,   58,
+       58,   58,   58,   58,   58,   58,   58,   58,   58
     },
 
     {
-       11,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,
-      -32,  -32,  -32,  -32,  -32,  -32,  -32
+       11,  -32,  -32,  -32,  -32,  -32,  -32,   59,  -32,  -32,
+      -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32
     },
 
     {
        11,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,
-      -33,  -33,  -33,  -33,  -33,  -33,  -33
+      -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33
     },
 
     {
        11,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,
-      -34,   56,   57,   57,  -34,  -34,  -34
+      -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34
 
     },
 
     {
        11,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
-      -35,   57,   57,   57,  -35,  -35,  -35
+      -35,   60,   61,   61,  -35,  -35,  -35,  -35,  -35
     },
 
     {
        11,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,
-      -36,  -36,  -36,  -36,  -36,  -36,  -36
+      -36,   61,   61,   61,  -36,  -36,  -36,  -36,  -36
     },
 
     {
-       11,  -37,  -37,   58,  -37,  -37,  -37,  -37,  -37,  -37,
-      -37,  -37,  -37,  -37,  -37,  -37,  -37
+       11,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,
+      -37,  -37,  -37,  -37,  -37,   62,  -37,  -37,  -37
     },
 
     {
        11,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,
-      -38,  -38,  -38,  -38,  -38,  -38,   59
+      -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38
     },
 
     {
-       11,  -39,   39,   40,  -39,  -39,   41,  -39,  -39,  -39,
-      -39,  -39,  -39,  -39,  -39,  -39,  -39
+       11,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,
+      -39,  -39,  -39,  -39,  -39,   63,  -39,  -39,  -39
 
     },
 
     {
-       11,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,
-      -40,  -40,  -40,  -40,  -40,  -40,  -40
+       11,  -40,  -40,   64,  -40,  -40,  -40,  -40,  -40,  -40,
+      -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40
     },
 
     {
-       11,   42,   42,   43,   42,   42,   42,   42,   42,   42,
-       42,   42,   42,   42,   42,   42,   42
+       11,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,
+      -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,   65
     },
 
     {
-       11,   42,   42,   43,   42,   42,   42,   42,   42,   42,
-       42,   42,   42,   42,   42,   42,   42
+       11,  -42,   42,   43,  -42,  -42,   44,  -42,  -42,  -42,
+      -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42
     },
 
     {
        11,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,
-      -43,  -43,  -43,  -43,  -43,  -43,  -43
+      -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43
     },
 
     {
-       11,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,
-      -44,  -44,  -44,   44,  -44,  -44,  -44
+       11,   45,   45,   46,   45,   45,   45,   45,   45,   45,
+       45,   45,   45,   45,   45,   45,   45,   45,   45
 
     },
 
     {
-       11,   45,   45,  -45,   45,   45,   45,   45,   45,   45,
-       45,   45,   45,   45,   45,   45,   45
+       11,   45,   45,   46,   45,   45,   45,   45,   45,   45,
+       45,   45,   45,   45,   45,   45,   45,   45,   45
     },
 
     {
-       11,  -46,   46,   47,  -46,  -46,  -46,  -46,  -46,  -46,
-      -46,  -46,  -46,  -46,  -46,  -46,  -46
+       11,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,
+      -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46
     },
 
     {
-       11,   48,  -47,  -47,   48,   48,   48,   48,   48,   48,
-       48,   48,   48,   48,   48,   48,   48
+       11,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,
+      -47,  -47,  -47,   47,  -47,  -47,  -47,  -47,  -47
     },
 
     {
-       11,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,
-      -48,  -48,  -48,  -48,  -48,  -48,  -48
+       11,   48,   48,  -48,   48,   48,   48,   48,   48,   48,
+       48,   48,   48,   48,   48,   48,   48,   48,   48
     },
 
     {
-       11,   49,   49,   50,   49,  -49,   49,   49,  -49,   49,
-       49,   49,   49,   49,   49,  -49,   49
+       11,  -49,   49,   50,  -49,  -49,  -49,  -49,  -49,  -49,
+      -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49
 
     },
 
     {
-       11,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
-      -50,  -50,  -50,  -50,  -50,  -50,  -50
+       11,   51,  -50,  -50,   51,   51,   51,   51,   51,   51,
+       51,   51,   51,   51,   51,   51,   51,   51,   51
     },
 
     {
-       11,  -51,  -51,   52,  -51,  -51,  -51,  -51,  -51,  -51,
-      -51,  -51,  -51,  -51,  -51,  -51,  -51
+       11,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
+      -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51
     },
 
     {
-       11,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
-      -52,  -52,  -52,  -52,  -52,  -52,  -52
+       11,   52,   52,   53,   52,  -52,   52,   52,  -52,   52,
+       52,   52,   52,   52,   52,   52,   52,  -52,   52
     },
 
     {
        11,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
-      -53,  -53,  -53,  -53,  -53,  -53,  -53
+      -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53
     },
 
     {
-       11,   54,   54,  -54,   54,   54,   54,   54,   54,   54,
-       54,   54,   54,   54,   54,   54,   54
+       11,  -54,  -54,   55,  -54,  -54,  -54,  -54,  -54,  -54,
+      -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54
 
     },
 
     {
        11,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
-      -55,  -55,  -55,  -55,  -55,  -55,  -55
+      -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55
     },
 
     {
-       11,  -56,  -56,  -56,  -56,  -56,  -56,  -56,  -56,  -56,
-      -56,   60,   57,   57,  -56,  -56,  -56
+       11,  -56,   56,  -56,  -56,  -56,  -56,  -56,  -56,  -56,
+      -56,  -56,  -56,  -56,  -56,  -56,  -56,  -56,  -56
     },
 
     {
        11,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
-      -57,   57,   57,   57,  -57,  -57,  -57
+      -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57
     },
 
     {
-       11,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
-      -58,  -58,  -58,  -58,  -58,  -58,  -58
+       11,   58,   58,  -58,   58,   58,   58,   58,   58,   58,
+       58,   58,   58,   58,   58,   58,   58,   58,   58
     },
 
     {
        11,  -59,  -59,  -59,  -59,  -59,  -59,  -59,  -59,  -59,
-      -59,  -59,  -59,  -59,  -59,  -59,  -59
+      -59,  -59,  -59,  -59,  -59,  -59,  -59,  -59,  -59
 
     },
 
     {
        11,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
-      -60,   57,   57,   57,  -60,  -60,  -60
+      -60,   66,   61,   61,  -60,  -60,  -60,  -60,  -60
+    },
+
+    {
+       11,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
+      -61,   61,   61,   61,  -61,  -61,  -61,  -61,  -61
+    },
+
+    {
+       11,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
+      -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62
+    },
+
+    {
+       11,  -63,  -63,  -63,  -63,  -63,  -63,  -63,  -63,  -63,
+      -63,  -63,  -63,  -63,  -63,  -63,  -63,  -63,  -63
+    },
+
+    {
+       11,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
+      -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64
+
+    },
+
+    {
+       11,  -65,  -65,  -65,  -65,  -65,  -65,  -65,  -65,  -65,
+      -65,  -65,  -65,  -65,  -65,  -65,  -65,  -65,  -65
+    },
+
+    {
+       11,  -66,  -66,  -66,  -66,  -66,  -66,  -66,  -66,  -66,
+      -66,   61,   61,   61,  -66,  -66,  -66,  -66,  -66
     },
 
     } ;
@@ -701,8 +732,8 @@ static void yy_fatal_error (yyconst char msg[]  );
 	*yy_cp = '\0'; \
 	(yy_c_buf_p) = yy_cp;
 
-#define YY_NUM_RULES 33
-#define YY_END_OF_BUFFER 34
+#define YY_NUM_RULES 38
+#define YY_END_OF_BUFFER 39
 /* This struct is not used in this scanner,
    but its presence is necessary. */
 struct yy_trans_info
@@ -710,14 +741,15 @@ struct yy_trans_info
 	flex_int32_t yy_verify;
 	flex_int32_t yy_nxt;
 	};
-static yyconst flex_int16_t yy_accept[61] =
+static yyconst flex_int16_t yy_accept[67] =
     {   0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
-       34,    5,    4,    2,    3,    7,    8,    6,   32,   29,
-       31,   24,   28,   27,   26,   22,   17,   13,   16,   20,
-       22,   11,   12,   19,   19,   14,   22,   22,    4,    2,
-        3,    3,    1,    6,   32,   29,   31,   30,   24,   23,
-       26,   25,   15,   20,    9,   19,   19,   21,   10,   18
+       39,    5,    4,    2,    3,    7,    8,    6,   37,   34,
+       36,   29,   33,   32,   31,   27,   26,   21,   13,   20,
+       24,   27,   11,   12,   23,   23,   18,   14,   19,   27,
+       27,    4,    2,    3,    3,    1,    6,   37,   34,   36,
+       35,   29,   28,   31,   30,   26,   15,   24,    9,   23,
+       23,   16,   17,   25,   10,   22
     } ;
 
 static yyconst flex_int32_t yy_ec[256] =
@@ -727,15 +759,15 @@ static yyconst flex_int32_t yy_ec[256] =
         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
         1,    2,    4,    5,    6,    1,    1,    7,    8,    9,
        10,    1,    1,    1,   11,   12,   12,   13,   13,   13,
-       13,   13,   13,   13,   13,   13,   13,    1,    1,    1,
-       14,    1,    1,    1,   13,   13,   13,   13,   13,   13,
+       13,   13,   13,   13,   13,   13,   13,    1,    1,   14,
+       15,   16,    1,    1,   13,   13,   13,   13,   13,   13,
        13,   13,   13,   13,   13,   13,   13,   13,   13,   13,
        13,   13,   13,   13,   13,   13,   13,   13,   13,   13,
-        1,   15,    1,    1,   13,    1,   13,   13,   13,   13,
+        1,   17,    1,    1,   13,    1,   13,   13,   13,   13,
 
        13,   13,   13,   13,   13,   13,   13,   13,   13,   13,
        13,   13,   13,   13,   13,   13,   13,   13,   13,   13,
-       13,   13,    1,   16,    1,    1,    1,    1,    1,    1,
+       13,   13,    1,   18,    1,    1,    1,    1,    1,    1,
         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
         1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
@@ -789,8 +821,8 @@ static char *text;
 static int text_size, text_asize;
 
 struct buffer {
-        struct buffer *parent;
-        YY_BUFFER_STATE state;
+	struct buffer *parent;
+	YY_BUFFER_STATE state;
 };
 
 struct buffer *current_buf;
@@ -920,7 +952,7 @@ static int input (void );
 /* This used to be an fputs(), but since the string might contain NUL's,
  * we now use fwrite().
  */
-#define ECHO do { if (fwrite( zconftext, zconfleng, 1, zconfout )) {} } while (0)
+#define ECHO fwrite( zconftext, zconfleng, 1, zconfout )
 #endif
 
 /* Gets input and stuffs it into "buf".  number of characters read, or YY_NULL,
@@ -1142,22 +1174,38 @@ return T_UNEQUAL;
 	YY_BREAK
 case 16:
 YY_RULE_SETUP
+return T_LESS_EQUAL;
+	YY_BREAK
+case 17:
+YY_RULE_SETUP
+return T_GREATER_EQUAL;
+	YY_BREAK
+case 18:
+YY_RULE_SETUP
+return T_LESS;
+	YY_BREAK
+case 19:
+YY_RULE_SETUP
+return T_GREATER;
+	YY_BREAK
+case 20:
+YY_RULE_SETUP
 {
 		str = zconftext[0];
 		new_string();
 		BEGIN(STRING);
 	}
 	YY_BREAK
-case 17:
-/* rule 17 can match eol */
+case 21:
+/* rule 21 can match eol */
 YY_RULE_SETUP
 BEGIN(INITIAL); current_file->lineno++; return T_EOL;
 	YY_BREAK
-case 18:
+case 22:
 YY_RULE_SETUP
 /* ignore */
 	YY_BREAK
-case 19:
+case 23:
 YY_RULE_SETUP
 {
 		const struct kconf_id *id = kconf_id_lookup(zconftext, zconfleng);
@@ -1170,27 +1218,35 @@ YY_RULE_SETUP
 		return T_WORD;
 	}
 	YY_BREAK
-case 20:
+case 24:
 YY_RULE_SETUP
 /* comment */
 	YY_BREAK
-case 21:
-/* rule 21 can match eol */
+case 25:
+/* rule 25 can match eol */
 YY_RULE_SETUP
 current_file->lineno++;
 	YY_BREAK
-case 22:
+case 26:
 YY_RULE_SETUP
 
 	YY_BREAK
+case 27:
+YY_RULE_SETUP
+{
+		fprintf(stderr,
+		        "%s:%d:warning: ignoring unsupported character '%c'\n",
+		        zconf_curname(), zconf_lineno(), *zconftext);
+	}
+	YY_BREAK
 case YY_STATE_EOF(PARAM):
 {
 		BEGIN(INITIAL);
 	}
 	YY_BREAK
 
-case 23:
-/* rule 23 can match eol */
+case 28:
+/* rule 28 can match eol */
 *yy_cp = (yy_hold_char); /* undo effects of setting up zconftext */
 (yy_c_buf_p) = yy_cp -= 1;
 YY_DO_BEFORE_ACTION; /* set up zconftext again */
@@ -1201,14 +1257,14 @@ YY_RULE_SETUP
 		return T_WORD_QUOTE;
 	}
 	YY_BREAK
-case 24:
+case 29:
 YY_RULE_SETUP
 {
 		append_string(zconftext, zconfleng);
 	}
 	YY_BREAK
-case 25:
-/* rule 25 can match eol */
+case 30:
+/* rule 30 can match eol */
 *yy_cp = (yy_hold_char); /* undo effects of setting up zconftext */
 (yy_c_buf_p) = yy_cp -= 1;
 YY_DO_BEFORE_ACTION; /* set up zconftext again */
@@ -1219,13 +1275,13 @@ YY_RULE_SETUP
 		return T_WORD_QUOTE;
 	}
 	YY_BREAK
-case 26:
+case 31:
 YY_RULE_SETUP
 {
 		append_string(zconftext + 1, zconfleng - 1);
 	}
 	YY_BREAK
-case 27:
+case 32:
 YY_RULE_SETUP
 {
 		if (str == zconftext[0]) {
@@ -1236,8 +1292,8 @@ YY_RULE_SETUP
 			append_string(zconftext, 1);
 	}
 	YY_BREAK
-case 28:
-/* rule 28 can match eol */
+case 33:
+/* rule 33 can match eol */
 YY_RULE_SETUP
 {
 		printf("%s:%d:warning: multi-line strings not supported\n", zconf_curname(), zconf_lineno());
@@ -1252,7 +1308,7 @@ case YY_STATE_EOF(STRING):
 	}
 	YY_BREAK
 
-case 29:
+case 34:
 YY_RULE_SETUP
 {
 		ts = 0;
@@ -1277,8 +1333,8 @@ YY_RULE_SETUP
 		}
 	}
 	YY_BREAK
-case 30:
-/* rule 30 can match eol */
+case 35:
+/* rule 35 can match eol */
 *yy_cp = (yy_hold_char); /* undo effects of setting up zconftext */
 (yy_c_buf_p) = yy_cp -= 1;
 YY_DO_BEFORE_ACTION; /* set up zconftext again */
@@ -1289,15 +1345,15 @@ YY_RULE_SETUP
 		return T_HELPTEXT;
 	}
 	YY_BREAK
-case 31:
-/* rule 31 can match eol */
+case 36:
+/* rule 36 can match eol */
 YY_RULE_SETUP
 {
 		current_file->lineno++;
 		append_string("\n", 1);
 	}
 	YY_BREAK
-case 32:
+case 37:
 YY_RULE_SETUP
 {
 		while (zconfleng) {
@@ -1328,7 +1384,7 @@ case YY_STATE_EOF(COMMAND):
 	yyterminate();
 }
 	YY_BREAK
-case 33:
+case 38:
 YY_RULE_SETUP
 YY_FATAL_ERROR( "flex scanner jammed" );
 	YY_BREAK
diff --git a/backport/kconf/zconf.tab.c b/backport/kconf/zconf.tab.c
index f636141e7bfd..7a4d658c2066 100644
--- a/backport/kconf/zconf.tab.c
+++ b/backport/kconf/zconf.tab.c
@@ -1,9 +1,8 @@
-/* A Bison parser, made by GNU Bison 2.4.3.  */
+/* A Bison parser, made by GNU Bison 2.5.1.  */
 
-/* Skeleton implementation for Bison's Yacc-like parsers in C
+/* Bison implementation for Yacc-like parsers in C
    
-      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006,
-   2009, 2010 Free Software Foundation, Inc.
+      Copyright (C) 1984, 1989-1990, 2000-2012 Free Software Foundation, Inc.
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
@@ -45,7 +44,7 @@
 #define YYBISON 1
 
 /* Bison version.  */
-#define YYBISON_VERSION "2.4.3"
+#define YYBISON_VERSION "2.5.1"
 
 /* Skeleton name.  */
 #define YYSKELETON_NAME "yacc.c"
@@ -109,6 +108,14 @@ static struct menu *current_menu, *current_entry;
 
 
 
+# ifndef YY_NULL
+#  if defined __cplusplus && 201103L <= __cplusplus
+#   define YY_NULL nullptr
+#  else
+#   define YY_NULL 0
+#  endif
+# endif
+
 /* Enabling traces.  */
 #ifndef YYDEBUG
 # define YYDEBUG 1
@@ -160,13 +167,17 @@ static struct menu *current_menu, *current_entry;
      T_WORD = 281,
      T_WORD_QUOTE = 282,
      T_UNEQUAL = 283,
-     T_CLOSE_PAREN = 284,
-     T_OPEN_PAREN = 285,
-     T_EOL = 286,
-     T_OR = 287,
-     T_AND = 288,
-     T_EQUAL = 289,
-     T_NOT = 290
+     T_LESS = 284,
+     T_LESS_EQUAL = 285,
+     T_GREATER = 286,
+     T_GREATER_EQUAL = 287,
+     T_CLOSE_PAREN = 288,
+     T_OPEN_PAREN = 289,
+     T_EOL = 290,
+     T_OR = 291,
+     T_AND = 292,
+     T_EQUAL = 293,
+     T_NOT = 294
    };
 #endif
 
@@ -302,11 +313,12 @@ YYID (yyi)
 #    define alloca _alloca
 #   else
 #    define YYSTACK_ALLOC alloca
-#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
+#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
      || defined __cplusplus || defined _MSC_VER)
 #     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
-#     ifndef _STDLIB_H
-#      define _STDLIB_H 1
+      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
+#     ifndef EXIT_SUCCESS
+#      define EXIT_SUCCESS 0
 #     endif
 #    endif
 #   endif
@@ -329,24 +341,24 @@ YYID (yyi)
 #  ifndef YYSTACK_ALLOC_MAXIMUM
 #   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
 #  endif
-#  if (defined __cplusplus && ! defined _STDLIB_H \
+#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
        && ! ((defined YYMALLOC || defined malloc) \
 	     && (defined YYFREE || defined free)))
 #   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
-#   ifndef _STDLIB_H
-#    define _STDLIB_H 1
+#   ifndef EXIT_SUCCESS
+#    define EXIT_SUCCESS 0
 #   endif
 #  endif
 #  ifndef YYMALLOC
 #   define YYMALLOC malloc
-#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
+#   if ! defined malloc && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
      || defined __cplusplus || defined _MSC_VER)
 void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
 #   endif
 #  endif
 #  ifndef YYFREE
 #   define YYFREE free
-#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
+#   if ! defined free && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
      || defined __cplusplus || defined _MSC_VER)
 void free (void *); /* INFRINGES ON USER NAME SPACE */
 #   endif
@@ -375,23 +387,7 @@ union yyalloc
      ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
       + YYSTACK_GAP_MAXIMUM)
 
-/* Copy COUNT objects from FROM to TO.  The source and destination do
-   not overlap.  */
-# ifndef YYCOPY
-#  if defined __GNUC__ && 1 < __GNUC__
-#   define YYCOPY(To, From, Count) \
-      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
-#  else
-#   define YYCOPY(To, From, Count)		\
-      do					\
-	{					\
-	  YYSIZE_T yyi;				\
-	  for (yyi = 0; yyi < (Count); yyi++)	\
-	    (To)[yyi] = (From)[yyi];		\
-	}					\
-      while (YYID (0))
-#  endif
-# endif
+# define YYCOPY_NEEDED 1
 
 /* Relocate STACK from its old location to the new one.  The
    local variables YYSIZE and YYSTACKSIZE give the old and new number of
@@ -411,23 +407,43 @@ union yyalloc
 
 #endif
 
+#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
+/* Copy COUNT objects from SRC to DST.  The source and destination do
+   not overlap.  */
+# ifndef YYCOPY
+#  if defined __GNUC__ && 1 < __GNUC__
+#   define YYCOPY(Dst, Src, Count) \
+      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
+#  else
+#   define YYCOPY(Dst, Src, Count)              \
+      do                                        \
+        {                                       \
+          YYSIZE_T yyi;                         \
+          for (yyi = 0; yyi < (Count); yyi++)   \
+            (Dst)[yyi] = (Src)[yyi];            \
+        }                                       \
+      while (YYID (0))
+#  endif
+# endif
+#endif /* !YYCOPY_NEEDED */
+
 /* YYFINAL -- State number of the termination state.  */
 #define YYFINAL  11
 /* YYLAST -- Last index in YYTABLE.  */
-#define YYLAST   290
+#define YYLAST   298
 
 /* YYNTOKENS -- Number of terminals.  */
-#define YYNTOKENS  36
+#define YYNTOKENS  40
 /* YYNNTS -- Number of nonterminals.  */
 #define YYNNTS  50
 /* YYNRULES -- Number of rules.  */
-#define YYNRULES  118
+#define YYNRULES  122
 /* YYNRULES -- Number of states.  */
-#define YYNSTATES  191
+#define YYNSTATES  199
 
 /* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
 #define YYUNDEFTOK  2
-#define YYMAXUTOK   290
+#define YYMAXUTOK   294
 
 #define YYTRANSLATE(YYX)						\
   ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)
@@ -464,7 +480,7 @@ static const yytype_uint8 yytranslate[] =
        5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
       15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
       25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
-      35
+      35,    36,    37,    38,    39
 };
 
 #if YYDEBUG
@@ -483,64 +499,67 @@ static const yytype_uint16 yyprhs[] =
      235,   238,   241,   244,   248,   252,   255,   258,   261,   262,
      265,   268,   271,   276,   277,   280,   283,   286,   287,   290,
      292,   294,   297,   300,   303,   305,   308,   309,   312,   314,
-     318,   322,   326,   329,   333,   337,   339,   341,   342
+     318,   322,   326,   330,   334,   338,   342,   345,   349,   353,
+     355,   357,   358
 };
 
 /* YYRHS -- A `-1'-separated list of the rules' RHS.  */
 static const yytype_int8 yyrhs[] =
 {
-      37,     0,    -1,    81,    38,    -1,    38,    -1,    63,    39,
-      -1,    39,    -1,    -1,    39,    41,    -1,    39,    55,    -1,
-      39,    67,    -1,    39,    80,    -1,    39,    26,     1,    31,
-      -1,    39,    40,     1,    31,    -1,    39,     1,    31,    -1,
+      41,     0,    -1,    85,    42,    -1,    42,    -1,    67,    43,
+      -1,    43,    -1,    -1,    43,    45,    -1,    43,    59,    -1,
+      43,    71,    -1,    43,    84,    -1,    43,    26,     1,    35,
+      -1,    43,    44,     1,    35,    -1,    43,     1,    35,    -1,
       16,    -1,    18,    -1,    19,    -1,    21,    -1,    17,    -1,
-      22,    -1,    20,    -1,    23,    -1,    31,    -1,    61,    -1,
-      71,    -1,    44,    -1,    46,    -1,    69,    -1,    26,     1,
-      31,    -1,     1,    31,    -1,    10,    26,    31,    -1,    43,
-      47,    -1,    11,    26,    31,    -1,    45,    47,    -1,    -1,
-      47,    48,    -1,    47,    49,    -1,    47,    75,    -1,    47,
-      73,    -1,    47,    42,    -1,    47,    31,    -1,    19,    78,
-      31,    -1,    18,    79,    82,    31,    -1,    20,    83,    82,
-      31,    -1,    21,    26,    82,    31,    -1,    22,    84,    84,
-      82,    31,    -1,    24,    50,    31,    -1,    -1,    50,    26,
-      51,    -1,    -1,    34,    79,    -1,     7,    85,    31,    -1,
-      52,    56,    -1,    80,    -1,    53,    58,    54,    -1,    -1,
-      56,    57,    -1,    56,    75,    -1,    56,    73,    -1,    56,
-      31,    -1,    56,    42,    -1,    18,    79,    82,    31,    -1,
-      19,    78,    31,    -1,    17,    31,    -1,    20,    26,    82,
-      31,    -1,    -1,    58,    41,    -1,    14,    83,    81,    -1,
-      80,    -1,    59,    62,    60,    -1,    -1,    62,    41,    -1,
-      62,    67,    -1,    62,    55,    -1,     3,    79,    81,    -1,
-       4,    79,    31,    -1,    64,    76,    74,    -1,    80,    -1,
-      65,    68,    66,    -1,    -1,    68,    41,    -1,    68,    67,
-      -1,    68,    55,    -1,     6,    79,    31,    -1,     9,    79,
-      31,    -1,    70,    74,    -1,    12,    31,    -1,    72,    13,
-      -1,    -1,    74,    75,    -1,    74,    31,    -1,    74,    42,
-      -1,    16,    25,    83,    31,    -1,    -1,    76,    77,    -1,
-      76,    31,    -1,    23,    82,    -1,    -1,    79,    82,    -1,
-      26,    -1,    27,    -1,     5,    31,    -1,     8,    31,    -1,
-      15,    31,    -1,    31,    -1,    81,    31,    -1,    -1,    14,
-      83,    -1,    84,    -1,    84,    34,    84,    -1,    84,    28,
-      84,    -1,    30,    83,    29,    -1,    35,    83,    -1,    83,
-      32,    83,    -1,    83,    33,    83,    -1,    26,    -1,    27,
-      -1,    -1,    26,    -1
+      22,    -1,    20,    -1,    23,    -1,    35,    -1,    65,    -1,
+      75,    -1,    48,    -1,    50,    -1,    73,    -1,    26,     1,
+      35,    -1,     1,    35,    -1,    10,    26,    35,    -1,    47,
+      51,    -1,    11,    26,    35,    -1,    49,    51,    -1,    -1,
+      51,    52,    -1,    51,    53,    -1,    51,    79,    -1,    51,
+      77,    -1,    51,    46,    -1,    51,    35,    -1,    19,    82,
+      35,    -1,    18,    83,    86,    35,    -1,    20,    87,    86,
+      35,    -1,    21,    26,    86,    35,    -1,    22,    88,    88,
+      86,    35,    -1,    24,    54,    35,    -1,    -1,    54,    26,
+      55,    -1,    -1,    38,    83,    -1,     7,    89,    35,    -1,
+      56,    60,    -1,    84,    -1,    57,    62,    58,    -1,    -1,
+      60,    61,    -1,    60,    79,    -1,    60,    77,    -1,    60,
+      35,    -1,    60,    46,    -1,    18,    83,    86,    35,    -1,
+      19,    82,    35,    -1,    17,    35,    -1,    20,    26,    86,
+      35,    -1,    -1,    62,    45,    -1,    14,    87,    85,    -1,
+      84,    -1,    63,    66,    64,    -1,    -1,    66,    45,    -1,
+      66,    71,    -1,    66,    59,    -1,     3,    83,    85,    -1,
+       4,    83,    35,    -1,    68,    80,    78,    -1,    84,    -1,
+      69,    72,    70,    -1,    -1,    72,    45,    -1,    72,    71,
+      -1,    72,    59,    -1,     6,    83,    35,    -1,     9,    83,
+      35,    -1,    74,    78,    -1,    12,    35,    -1,    76,    13,
+      -1,    -1,    78,    79,    -1,    78,    35,    -1,    78,    46,
+      -1,    16,    25,    87,    35,    -1,    -1,    80,    81,    -1,
+      80,    35,    -1,    23,    86,    -1,    -1,    83,    86,    -1,
+      26,    -1,    27,    -1,     5,    35,    -1,     8,    35,    -1,
+      15,    35,    -1,    35,    -1,    85,    35,    -1,    -1,    14,
+      87,    -1,    88,    -1,    88,    29,    88,    -1,    88,    30,
+      88,    -1,    88,    31,    88,    -1,    88,    32,    88,    -1,
+      88,    38,    88,    -1,    88,    28,    88,    -1,    34,    87,
+      33,    -1,    39,    87,    -1,    87,    36,    87,    -1,    87,
+      37,    87,    -1,    26,    -1,    27,    -1,    -1,    26,    -1
 };
 
 /* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
 static const yytype_uint16 yyrline[] =
 {
-       0,   104,   104,   104,   106,   106,   108,   110,   111,   112,
-     113,   114,   115,   119,   123,   123,   123,   123,   123,   123,
-     123,   123,   127,   128,   129,   130,   131,   132,   136,   137,
-     143,   151,   157,   165,   175,   177,   178,   179,   180,   181,
-     182,   185,   193,   199,   209,   215,   221,   224,   226,   237,
-     238,   243,   252,   257,   265,   268,   270,   271,   272,   273,
-     274,   277,   283,   294,   300,   310,   312,   317,   325,   333,
-     336,   338,   339,   340,   345,   352,   359,   364,   372,   375,
-     377,   378,   379,   382,   390,   397,   404,   410,   417,   419,
-     420,   421,   424,   432,   434,   435,   438,   445,   447,   452,
-     453,   456,   457,   458,   462,   463,   466,   467,   470,   471,
-     472,   473,   474,   475,   476,   479,   480,   483,   484
+       0,   108,   108,   108,   110,   110,   112,   114,   115,   116,
+     117,   118,   119,   123,   127,   127,   127,   127,   127,   127,
+     127,   127,   131,   132,   133,   134,   135,   136,   140,   141,
+     147,   155,   161,   169,   179,   181,   182,   183,   184,   185,
+     186,   189,   197,   203,   213,   219,   225,   228,   230,   241,
+     242,   247,   256,   261,   269,   272,   274,   275,   276,   277,
+     278,   281,   287,   298,   304,   314,   316,   321,   329,   337,
+     340,   342,   343,   344,   349,   356,   363,   368,   376,   379,
+     381,   382,   383,   386,   394,   401,   408,   414,   421,   423,
+     424,   425,   428,   436,   438,   439,   442,   449,   451,   456,
+     457,   460,   461,   462,   466,   467,   470,   471,   474,   475,
+     476,   477,   478,   479,   480,   481,   482,   483,   484,   487,
+     488,   491,   492
 };
 #endif
 
@@ -554,6 +573,7 @@ static const char *const yytname[] =
   "T_MENUCONFIG", "T_HELP", "T_HELPTEXT", "T_IF", "T_ENDIF", "T_DEPENDS",
   "T_OPTIONAL", "T_PROMPT", "T_TYPE", "T_DEFAULT", "T_SELECT", "T_RANGE",
   "T_VISIBLE", "T_OPTION", "T_ON", "T_WORD", "T_WORD_QUOTE", "T_UNEQUAL",
+  "T_LESS", "T_LESS_EQUAL", "T_GREATER", "T_GREATER_EQUAL",
   "T_CLOSE_PAREN", "T_OPEN_PAREN", "T_EOL", "T_OR", "T_AND", "T_EQUAL",
   "T_NOT", "$accept", "input", "start", "stmt_list", "option_name",
   "common_stmt", "option_error", "config_entry_start", "config_stmt",
@@ -565,7 +585,7 @@ static const char *const yytname[] =
   "menu_entry", "menu_end", "menu_stmt", "menu_block", "source_stmt",
   "comment", "comment_stmt", "help_start", "help", "depends_list",
   "depends", "visibility_list", "visible", "prompt_stmt_opt", "prompt",
-  "end", "nl", "if_expr", "expr", "symbol", "word_opt", 0
+  "end", "nl", "if_expr", "expr", "symbol", "word_opt", YY_NULL
 };
 #endif
 
@@ -577,25 +597,26 @@ static const yytype_uint16 yytoknum[] =
        0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
      265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
      275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
-     285,   286,   287,   288,   289,   290
+     285,   286,   287,   288,   289,   290,   291,   292,   293,   294
 };
 # endif
 
 /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
 static const yytype_uint8 yyr1[] =
 {
-       0,    36,    37,    37,    38,    38,    39,    39,    39,    39,
-      39,    39,    39,    39,    40,    40,    40,    40,    40,    40,
-      40,    40,    41,    41,    41,    41,    41,    41,    42,    42,
-      43,    44,    45,    46,    47,    47,    47,    47,    47,    47,
-      47,    48,    48,    48,    48,    48,    49,    50,    50,    51,
-      51,    52,    53,    54,    55,    56,    56,    56,    56,    56,
-      56,    57,    57,    57,    57,    58,    58,    59,    60,    61,
-      62,    62,    62,    62,    63,    64,    65,    66,    67,    68,
-      68,    68,    68,    69,    70,    71,    72,    73,    74,    74,
-      74,    74,    75,    76,    76,    76,    77,    78,    78,    79,
-      79,    80,    80,    80,    81,    81,    82,    82,    83,    83,
-      83,    83,    83,    83,    83,    84,    84,    85,    85
+       0,    40,    41,    41,    42,    42,    43,    43,    43,    43,
+      43,    43,    43,    43,    44,    44,    44,    44,    44,    44,
+      44,    44,    45,    45,    45,    45,    45,    45,    46,    46,
+      47,    48,    49,    50,    51,    51,    51,    51,    51,    51,
+      51,    52,    52,    52,    52,    52,    53,    54,    54,    55,
+      55,    56,    57,    58,    59,    60,    60,    60,    60,    60,
+      60,    61,    61,    61,    61,    62,    62,    63,    64,    65,
+      66,    66,    66,    66,    67,    68,    69,    70,    71,    72,
+      72,    72,    72,    73,    74,    75,    76,    77,    78,    78,
+      78,    78,    79,    80,    80,    80,    81,    82,    82,    83,
+      83,    84,    84,    84,    85,    85,    86,    86,    87,    87,
+      87,    87,    87,    87,    87,    87,    87,    87,    87,    88,
+      88,    89,    89
 };
 
 /* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
@@ -612,180 +633,186 @@ static const yytype_uint8 yyr2[] =
        2,     2,     2,     3,     3,     2,     2,     2,     0,     2,
        2,     2,     4,     0,     2,     2,     2,     0,     2,     1,
        1,     2,     2,     2,     1,     2,     0,     2,     1,     3,
-       3,     3,     2,     3,     3,     1,     1,     0,     1
+       3,     3,     3,     3,     3,     3,     2,     3,     3,     1,
+       1,     0,     1
 };
 
-/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
-   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
+/* YYDEFACT[STATE-NAME] -- Default reduction number in state STATE-NUM.
+   Performed when YYTABLE doesn't specify something else to do.  Zero
    means the default is an error.  */
 static const yytype_uint8 yydefact[] =
 {
        6,     0,   104,     0,     3,     0,     6,     6,    99,   100,
-       0,     1,     0,     0,     0,     0,   117,     0,     0,     0,
+       0,     1,     0,     0,     0,     0,   121,     0,     0,     0,
        0,     0,     0,    14,    18,    15,    16,    20,    17,    19,
       21,     0,    22,     0,     7,    34,    25,    34,    26,    55,
       65,     8,    70,    23,    93,    79,     9,    27,    88,    24,
-      10,     0,   105,     2,    74,    13,     0,   101,     0,   118,
-       0,   102,     0,     0,     0,   115,   116,     0,     0,     0,
+      10,     0,   105,     2,    74,    13,     0,   101,     0,   122,
+       0,   102,     0,     0,     0,   119,   120,     0,     0,     0,
      108,   103,     0,     0,     0,     0,     0,     0,     0,    88,
-       0,     0,    75,    83,    51,    84,    30,    32,     0,   112,
-       0,     0,    67,     0,     0,    11,    12,     0,     0,     0,
-       0,    97,     0,     0,     0,    47,     0,    40,    39,    35,
-      36,     0,    38,    37,     0,     0,    97,     0,    59,    60,
-      56,    58,    57,    66,    54,    53,    71,    73,    69,    72,
-      68,   106,    95,     0,    94,    80,    82,    78,    81,    77,
-      90,    91,    89,   111,   113,   114,   110,   109,    29,    86,
-       0,   106,     0,   106,   106,   106,     0,     0,     0,    87,
-      63,   106,     0,   106,     0,    96,     0,     0,    41,    98,
-       0,     0,   106,    49,    46,    28,     0,    62,     0,   107,
-      92,    42,    43,    44,     0,     0,    48,    61,    64,    45,
-      50
+       0,     0,    75,    83,    51,    84,    30,    32,     0,   116,
+       0,     0,    67,     0,     0,     0,     0,     0,     0,    11,
+      12,     0,     0,     0,     0,    97,     0,     0,     0,    47,
+       0,    40,    39,    35,    36,     0,    38,    37,     0,     0,
+      97,     0,    59,    60,    56,    58,    57,    66,    54,    53,
+      71,    73,    69,    72,    68,   106,    95,     0,    94,    80,
+      82,    78,    81,    77,    90,    91,    89,   115,   117,   118,
+     114,   109,   110,   111,   112,   113,    29,    86,     0,   106,
+       0,   106,   106,   106,     0,     0,     0,    87,    63,   106,
+       0,   106,     0,    96,     0,     0,    41,    98,     0,     0,
+     106,    49,    46,    28,     0,    62,     0,   107,    92,    42,
+      43,    44,     0,     0,    48,    61,    64,    45,    50
 };
 
 /* YYDEFGOTO[NTERM-NUM].  */
 static const yytype_int16 yydefgoto[] =
 {
-      -1,     3,     4,     5,    33,    34,   108,    35,    36,    37,
-      38,    74,   109,   110,   157,   186,    39,    40,   124,    41,
-      76,   120,    77,    42,   128,    43,    78,     6,    44,    45,
-     137,    46,    80,    47,    48,    49,   111,   112,    81,   113,
-      79,   134,   152,   153,    50,     7,   165,    69,    70,    60
+      -1,     3,     4,     5,    33,    34,   112,    35,    36,    37,
+      38,    74,   113,   114,   165,   194,    39,    40,   128,    41,
+      76,   124,    77,    42,   132,    43,    78,     6,    44,    45,
+     141,    46,    80,    47,    48,    49,   115,   116,    81,   117,
+      79,   138,   160,   161,    50,     7,   173,    69,    70,    60
 };
 
 /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
    STATE-NUM.  */
-#define YYPACT_NINF -90
+#define YYPACT_NINF -91
 static const yytype_int16 yypact[] =
 {
-       4,    42,   -90,    96,   -90,   111,   -90,    15,   -90,   -90,
-      75,   -90,    82,    42,   104,    42,   110,   107,    42,   115,
-     125,    -4,   121,   -90,   -90,   -90,   -90,   -90,   -90,   -90,
-     -90,   162,   -90,   163,   -90,   -90,   -90,   -90,   -90,   -90,
-     -90,   -90,   -90,   -90,   -90,   -90,   -90,   -90,   -90,   -90,
-     -90,   139,   -90,   -90,   138,   -90,   142,   -90,   143,   -90,
-     152,   -90,   164,   167,   168,   -90,   -90,    -4,    -4,    77,
-     -18,   -90,   177,   185,    33,    71,   195,   247,   236,    -2,
-     236,   171,   -90,   -90,   -90,   -90,   -90,   -90,    41,   -90,
-      -4,    -4,   138,    97,    97,   -90,   -90,   186,   187,   194,
-      42,    42,    -4,   196,    97,   -90,   219,   -90,   -90,   -90,
-     -90,   210,   -90,   -90,   204,    42,    42,   199,   -90,   -90,
-     -90,   -90,   -90,   -90,   -90,   -90,   -90,   -90,   -90,   -90,
-     -90,   222,   -90,   223,   -90,   -90,   -90,   -90,   -90,   -90,
-     -90,   -90,   -90,   -90,   215,   -90,   -90,   -90,   -90,   -90,
-      -4,   222,   228,   222,    -5,   222,    97,    35,   229,   -90,
-     -90,   222,   232,   222,    -4,   -90,   135,   233,   -90,   -90,
-     234,   235,   222,   240,   -90,   -90,   237,   -90,   239,   -13,
-     -90,   -90,   -90,   -90,   244,    42,   -90,   -90,   -90,   -90,
-     -90
+      19,    37,   -91,    13,   -91,    79,   -91,    20,   -91,   -91,
+     -16,   -91,    21,    37,    25,    37,    41,    36,    37,    78,
+      83,    31,    56,   -91,   -91,   -91,   -91,   -91,   -91,   -91,
+     -91,   116,   -91,   127,   -91,   -91,   -91,   -91,   -91,   -91,
+     -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,
+     -91,   147,   -91,   -91,   105,   -91,   109,   -91,   111,   -91,
+     114,   -91,   136,   137,   142,   -91,   -91,    31,    31,    76,
+     254,   -91,   143,   146,    27,   115,   207,   258,   243,   -14,
+     243,   179,   -91,   -91,   -91,   -91,   -91,   -91,    -7,   -91,
+      31,    31,   105,    51,    51,    51,    51,    51,    51,   -91,
+     -91,   156,   168,   181,    37,    37,    31,   178,    51,   -91,
+     206,   -91,   -91,   -91,   -91,   196,   -91,   -91,   175,    37,
+      37,   185,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,
+     -91,   -91,   -91,   -91,   -91,   214,   -91,   230,   -91,   -91,
+     -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   183,   -91,
+     -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,    31,   214,
+     194,   214,    45,   214,    51,    26,   195,   -91,   -91,   214,
+     197,   214,    31,   -91,   139,   208,   -91,   -91,   220,   224,
+     214,   222,   -91,   -91,   226,   -91,   227,   123,   -91,   -91,
+     -91,   -91,   235,    37,   -91,   -91,   -91,   -91,   -91
 };
 
 /* YYPGOTO[NTERM-NUM].  */
 static const yytype_int16 yypgoto[] =
 {
-     -90,   -90,   269,   271,   -90,    23,   -70,   -90,   -90,   -90,
-     -90,   243,   -90,   -90,   -90,   -90,   -90,   -90,   -90,   -48,
-     -90,   -90,   -90,   -90,   -90,   -90,   -90,   -90,   -90,   -90,
-     -90,   -20,   -90,   -90,   -90,   -90,   -90,   206,   205,   -68,
-     -90,   -90,   169,    -1,    27,    -7,   118,   -66,   -89,   -90
+     -91,   -91,   264,   268,   -91,    30,   -65,   -91,   -91,   -91,
+     -91,   238,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   -12,
+     -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,
+     -91,    -5,   -91,   -91,   -91,   -91,   -91,   200,   209,   -61,
+     -91,   -91,   170,    -1,    65,     0,   118,   -66,   -90,   -91
 };
 
 /* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
    positive, shift that token.  If negative, reduce the rule which
-   number is the opposite.  If zero, do what YYDEFACT says.
-   If YYTABLE_NINF, syntax error.  */
+   number is the opposite.  If YYTABLE_NINF, syntax error.  */
 #define YYTABLE_NINF -86
 static const yytype_int16 yytable[] =
 {
-      10,    88,    89,    54,   146,   147,   119,     1,   122,   164,
-      93,   141,    56,   142,    58,   156,    94,    62,     1,    90,
-      91,   131,    65,    66,   144,   145,    67,    90,    91,   132,
-     127,    68,   136,   -31,    97,     2,   154,   -31,   -31,   -31,
-     -31,   -31,   -31,   -31,   -31,    98,    52,   -31,   -31,    99,
-     -31,   100,   101,   102,   103,   104,   -31,   105,   129,   106,
-     138,   173,    92,   141,   107,   142,   174,   172,     8,     9,
-     143,   -33,    97,    90,    91,   -33,   -33,   -33,   -33,   -33,
-     -33,   -33,   -33,    98,   166,   -33,   -33,    99,   -33,   100,
-     101,   102,   103,   104,   -33,   105,    11,   106,   179,   151,
-     123,   126,   107,   135,   125,   130,     2,   139,     2,    90,
-      91,    -5,    12,    55,   161,    13,    14,    15,    16,    17,
-      18,    19,    20,    65,    66,    21,    22,    23,    24,    25,
-      26,    27,    28,    29,    30,    57,    59,    31,    61,    -4,
-      12,    63,    32,    13,    14,    15,    16,    17,    18,    19,
-      20,    64,    71,    21,    22,    23,    24,    25,    26,    27,
-      28,    29,    30,    72,    73,    31,   180,    90,    91,    52,
-      32,   -85,    97,    82,    83,   -85,   -85,   -85,   -85,   -85,
-     -85,   -85,   -85,    84,   190,   -85,   -85,    99,   -85,   -85,
-     -85,   -85,   -85,   -85,   -85,    85,    97,   106,    86,    87,
-     -52,   -52,   140,   -52,   -52,   -52,   -52,    98,    95,   -52,
-     -52,    99,   114,   115,   116,   117,    96,   148,   149,   150,
-     158,   106,   155,   159,    97,   163,   118,   -76,   -76,   -76,
-     -76,   -76,   -76,   -76,   -76,   160,   164,   -76,   -76,    99,
-      13,    14,    15,    16,    17,    18,    19,    20,    91,   106,
-      21,    22,    14,    15,   140,    17,    18,    19,    20,   168,
-     175,    21,    22,   177,   181,   182,   183,    32,   187,   167,
-     188,   169,   170,   171,   185,   189,    53,    51,    32,   176,
-      75,   178,   121,     0,   133,   162,     0,     0,     0,     0,
-     184
+      10,    88,    89,   150,   151,   152,   153,   154,   155,   135,
+      54,   123,    56,    11,    58,   126,   145,    62,   164,     2,
+     146,   136,     1,     1,   148,   149,   147,   -31,   101,    90,
+      91,   -31,   -31,   -31,   -31,   -31,   -31,   -31,   -31,   102,
+     162,   -31,   -31,   103,   -31,   104,   105,   106,   107,   108,
+     -31,   109,   181,   110,     2,    52,    55,    65,    66,   172,
+      57,   182,   111,     8,     9,    67,   131,    59,   140,    92,
+      68,    61,   145,   133,   180,   142,   146,    65,    66,    -5,
+      12,    90,    91,    13,    14,    15,    16,    17,    18,    19,
+      20,    71,   174,    21,    22,    23,    24,    25,    26,    27,
+      28,    29,    30,   159,    63,    31,   187,   127,   130,    64,
+     139,     2,    90,    91,    32,   -33,   101,    72,   169,   -33,
+     -33,   -33,   -33,   -33,   -33,   -33,   -33,   102,    73,   -33,
+     -33,   103,   -33,   104,   105,   106,   107,   108,   -33,   109,
+      52,   110,   129,   134,    82,   143,    83,    -4,    12,    84,
+     111,    13,    14,    15,    16,    17,    18,    19,    20,    90,
+      91,    21,    22,    23,    24,    25,    26,    27,    28,    29,
+      30,    85,    86,    31,   188,    90,    91,    87,    99,   -85,
+     101,   100,    32,   -85,   -85,   -85,   -85,   -85,   -85,   -85,
+     -85,   156,   198,   -85,   -85,   103,   -85,   -85,   -85,   -85,
+     -85,   -85,   -85,   157,   163,   110,   158,   166,   101,   167,
+     168,   171,   -52,   -52,   144,   -52,   -52,   -52,   -52,   102,
+      91,   -52,   -52,   103,   118,   119,   120,   121,   172,   176,
+     183,   101,   185,   110,   -76,   -76,   -76,   -76,   -76,   -76,
+     -76,   -76,   122,   189,   -76,   -76,   103,    13,    14,    15,
+      16,    17,    18,    19,    20,   190,   110,    21,    22,   191,
+     193,   195,   196,    14,    15,   144,    17,    18,    19,    20,
+     197,    53,    21,    22,    51,    75,   125,   175,    32,   177,
+     178,   179,    93,    94,    95,    96,    97,   184,   137,   186,
+     170,     0,    98,    32,     0,     0,     0,     0,   192
 };
 
+#define yypact_value_is_default(yystate) \
+  ((yystate) == (-91))
+
+#define yytable_value_is_error(yytable_value) \
+  YYID (0)
+
 static const yytype_int16 yycheck[] =
 {
-       1,    67,    68,    10,    93,    94,    76,     3,    76,    14,
-      28,    81,    13,    81,    15,   104,    34,    18,     3,    32,
-      33,    23,    26,    27,    90,    91,    30,    32,    33,    31,
-      78,    35,    80,     0,     1,    31,   102,     4,     5,     6,
-       7,     8,     9,    10,    11,    12,    31,    14,    15,    16,
-      17,    18,    19,    20,    21,    22,    23,    24,    78,    26,
-      80,    26,    69,   133,    31,   133,    31,   156,    26,    27,
-      29,     0,     1,    32,    33,     4,     5,     6,     7,     8,
-       9,    10,    11,    12,   150,    14,    15,    16,    17,    18,
-      19,    20,    21,    22,    23,    24,     0,    26,   164,   100,
-      77,    78,    31,    80,    77,    78,    31,    80,    31,    32,
-      33,     0,     1,    31,   115,     4,     5,     6,     7,     8,
-       9,    10,    11,    26,    27,    14,    15,    16,    17,    18,
-      19,    20,    21,    22,    23,    31,    26,    26,    31,     0,
-       1,    26,    31,     4,     5,     6,     7,     8,     9,    10,
-      11,    26,    31,    14,    15,    16,    17,    18,    19,    20,
-      21,    22,    23,     1,     1,    26,    31,    32,    33,    31,
-      31,     0,     1,    31,    31,     4,     5,     6,     7,     8,
-       9,    10,    11,    31,   185,    14,    15,    16,    17,    18,
-      19,    20,    21,    22,    23,    31,     1,    26,    31,    31,
-       5,     6,    31,     8,     9,    10,    11,    12,    31,    14,
-      15,    16,    17,    18,    19,    20,    31,    31,    31,    25,
-       1,    26,    26,    13,     1,    26,    31,     4,     5,     6,
-       7,     8,     9,    10,    11,    31,    14,    14,    15,    16,
-       4,     5,     6,     7,     8,     9,    10,    11,    33,    26,
-      14,    15,     5,     6,    31,     8,     9,    10,    11,    31,
-      31,    14,    15,    31,    31,    31,    31,    31,    31,   151,
-      31,   153,   154,   155,    34,    31,     7,     6,    31,   161,
-      37,   163,    76,    -1,    79,   116,    -1,    -1,    -1,    -1,
-     172
+       1,    67,    68,    93,    94,    95,    96,    97,    98,    23,
+      10,    76,    13,     0,    15,    76,    81,    18,   108,    35,
+      81,    35,     3,     3,    90,    91,    33,     0,     1,    36,
+      37,     4,     5,     6,     7,     8,     9,    10,    11,    12,
+     106,    14,    15,    16,    17,    18,    19,    20,    21,    22,
+      23,    24,    26,    26,    35,    35,    35,    26,    27,    14,
+      35,    35,    35,    26,    27,    34,    78,    26,    80,    69,
+      39,    35,   137,    78,   164,    80,   137,    26,    27,     0,
+       1,    36,    37,     4,     5,     6,     7,     8,     9,    10,
+      11,    35,   158,    14,    15,    16,    17,    18,    19,    20,
+      21,    22,    23,   104,    26,    26,   172,    77,    78,    26,
+      80,    35,    36,    37,    35,     0,     1,     1,   119,     4,
+       5,     6,     7,     8,     9,    10,    11,    12,     1,    14,
+      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
+      35,    26,    77,    78,    35,    80,    35,     0,     1,    35,
+      35,     4,     5,     6,     7,     8,     9,    10,    11,    36,
+      37,    14,    15,    16,    17,    18,    19,    20,    21,    22,
+      23,    35,    35,    26,    35,    36,    37,    35,    35,     0,
+       1,    35,    35,     4,     5,     6,     7,     8,     9,    10,
+      11,    35,   193,    14,    15,    16,    17,    18,    19,    20,
+      21,    22,    23,    35,    26,    26,    25,     1,     1,    13,
+      35,    26,     5,     6,    35,     8,     9,    10,    11,    12,
+      37,    14,    15,    16,    17,    18,    19,    20,    14,    35,
+      35,     1,    35,    26,     4,     5,     6,     7,     8,     9,
+      10,    11,    35,    35,    14,    15,    16,     4,     5,     6,
+       7,     8,     9,    10,    11,    35,    26,    14,    15,    35,
+      38,    35,    35,     5,     6,    35,     8,     9,    10,    11,
+      35,     7,    14,    15,     6,    37,    76,   159,    35,   161,
+     162,   163,    28,    29,    30,    31,    32,   169,    79,   171,
+     120,    -1,    38,    35,    -1,    -1,    -1,    -1,   180
 };
 
 /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
    symbol of state STATE-NUM.  */
 static const yytype_uint8 yystos[] =
 {
-       0,     3,    31,    37,    38,    39,    63,    81,    26,    27,
-      79,     0,     1,     4,     5,     6,     7,     8,     9,    10,
+       0,     3,    35,    41,    42,    43,    67,    85,    26,    27,
+      83,     0,     1,     4,     5,     6,     7,     8,     9,    10,
       11,    14,    15,    16,    17,    18,    19,    20,    21,    22,
-      23,    26,    31,    40,    41,    43,    44,    45,    46,    52,
-      53,    55,    59,    61,    64,    65,    67,    69,    70,    71,
-      80,    39,    31,    38,    81,    31,    79,    31,    79,    26,
-      85,    31,    79,    26,    26,    26,    27,    30,    35,    83,
-      84,    31,     1,     1,    47,    47,    56,    58,    62,    76,
-      68,    74,    31,    31,    31,    31,    31,    31,    83,    83,
-      32,    33,    81,    28,    34,    31,    31,     1,    12,    16,
-      18,    19,    20,    21,    22,    24,    26,    31,    42,    48,
-      49,    72,    73,    75,    17,    18,    19,    20,    31,    42,
-      57,    73,    75,    41,    54,    80,    41,    55,    60,    67,
-      80,    23,    31,    74,    77,    41,    55,    66,    67,    80,
-      31,    42,    75,    29,    83,    83,    84,    84,    31,    31,
-      25,    79,    78,    79,    83,    26,    84,    50,     1,    13,
-      31,    79,    78,    26,    14,    82,    83,    82,    31,    82,
-      82,    82,    84,    26,    31,    31,    82,    31,    82,    83,
-      31,    31,    31,    31,    82,    34,    51,    31,    31,    31,
-      79
+      23,    26,    35,    44,    45,    47,    48,    49,    50,    56,
+      57,    59,    63,    65,    68,    69,    71,    73,    74,    75,
+      84,    43,    35,    42,    85,    35,    83,    35,    83,    26,
+      89,    35,    83,    26,    26,    26,    27,    34,    39,    87,
+      88,    35,     1,     1,    51,    51,    60,    62,    66,    80,
+      72,    78,    35,    35,    35,    35,    35,    35,    87,    87,
+      36,    37,    85,    28,    29,    30,    31,    32,    38,    35,
+      35,     1,    12,    16,    18,    19,    20,    21,    22,    24,
+      26,    35,    46,    52,    53,    76,    77,    79,    17,    18,
+      19,    20,    35,    46,    61,    77,    79,    45,    58,    84,
+      45,    59,    64,    71,    84,    23,    35,    78,    81,    45,
+      59,    70,    71,    84,    35,    46,    79,    33,    87,    87,
+      88,    88,    88,    88,    88,    88,    35,    35,    25,    83,
+      82,    83,    87,    26,    88,    54,     1,    13,    35,    83,
+      82,    26,    14,    86,    87,    86,    35,    86,    86,    86,
+      88,    26,    35,    35,    86,    35,    86,    87,    35,    35,
+      35,    35,    86,    38,    55,    35,    35,    35,    83
 };
 
 #define yyerrok		(yyerrstatus = 0)
@@ -815,18 +842,18 @@ static const yytype_uint8 yystos[] =
 
 #define YYRECOVERING()  (!!yyerrstatus)
 
-#define YYBACKUP(Token, Value)					\
-do								\
-  if (yychar == YYEMPTY && yylen == 1)				\
-    {								\
-      yychar = (Token);						\
-      yylval = (Value);						\
-      yytoken = YYTRANSLATE (yychar);				\
-      YYPOPSTACK (1);						\
-      goto yybackup;						\
-    }								\
-  else								\
-    {								\
+#define YYBACKUP(Token, Value)                                  \
+do                                                              \
+  if (yychar == YYEMPTY)                                        \
+    {                                                           \
+      yychar = (Token);                                         \
+      yylval = (Value);                                         \
+      YYPOPSTACK (yylen);                                       \
+      yystate = *yyssp;                                         \
+      goto yybackup;                                            \
+    }                                                           \
+  else                                                          \
+    {                                                           \
       yyerror (YY_("syntax error: cannot back up")); \
       YYERROR;							\
     }								\
@@ -863,19 +890,10 @@ while (YYID (0))
 #endif
 
 
-/* YY_LOCATION_PRINT -- Print the location on the stream.
-   This macro was not mandated originally: define only if we know
-   we won't break user code: when these are the locations we know.  */
+/* This macro is provided for backward compatibility. */
 
 #ifndef YY_LOCATION_PRINT
-# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
-#  define YY_LOCATION_PRINT(File, Loc)			\
-     fprintf (File, "%d.%d-%d.%d",			\
-	      (Loc).first_line, (Loc).first_column,	\
-	      (Loc).last_line,  (Loc).last_column)
-# else
-#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
-# endif
+# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
 #endif
 
 
@@ -930,6 +948,8 @@ yy_symbol_value_print (yyoutput, yytype, yyvaluep)
     YYSTYPE const * const yyvaluep;
 #endif
 {
+  FILE *yyo = yyoutput;
+  YYUSE (yyo);
   if (!yyvaluep)
     return;
 # ifdef YYPRINT
@@ -1067,7 +1087,6 @@ int yydebug;
 # define YYMAXDEPTH 10000
 #endif
 
-
 
 #if YYERROR_VERBOSE
 
@@ -1170,115 +1189,142 @@ yytnamerr (char *yyres, const char *yystr)
 }
 # endif
 
-/* Copy into YYRESULT an error message about the unexpected token
-   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
-   including the terminating null byte.  If YYRESULT is null, do not
-   copy anything; just return the number of bytes that would be
-   copied.  As a special case, return 0 if an ordinary "syntax error"
-   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
-   size calculation.  */
-static YYSIZE_T
-yysyntax_error (char *yyresult, int yystate, int yychar)
-{
-  int yyn = yypact[yystate];
+/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
+   about the unexpected token YYTOKEN for the state stack whose top is
+   YYSSP.
 
-  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
-    return 0;
-  else
+   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
+   not large enough to hold the message.  In that case, also set
+   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
+   required number of bytes is too large to store.  */
+static int
+yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
+                yytype_int16 *yyssp, int yytoken)
+{
+  YYSIZE_T yysize0 = yytnamerr (YY_NULL, yytname[yytoken]);
+  YYSIZE_T yysize = yysize0;
+  YYSIZE_T yysize1;
+  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
+  /* Internationalized format string. */
+  const char *yyformat = YY_NULL;
+  /* Arguments of yyformat. */
+  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
+  /* Number of reported tokens (one for the "unexpected", one per
+     "expected"). */
+  int yycount = 0;
+
+  /* There are many possibilities here to consider:
+     - Assume YYFAIL is not used.  It's too flawed to consider.  See
+       <http://lists.gnu.org/archive/html/bison-patches/2009-12/msg00024.html>
+       for details.  YYERROR is fine as it does not invoke this
+       function.
+     - If this state is a consistent state with a default action, then
+       the only way this function was invoked is if the default action
+       is an error action.  In that case, don't check for expected
+       tokens because there are none.
+     - The only way there can be no lookahead present (in yychar) is if
+       this state is a consistent state with a default action.  Thus,
+       detecting the absence of a lookahead is sufficient to determine
+       that there is no unexpected or expected token to report.  In that
+       case, just report a simple "syntax error".
+     - Don't assume there isn't a lookahead just because this state is a
+       consistent state with a default action.  There might have been a
+       previous inconsistent state, consistent state with a non-default
+       action, or user semantic action that manipulated yychar.
+     - Of course, the expected token list depends on states to have
+       correct lookahead information, and it depends on the parser not
+       to perform extra reductions after fetching a lookahead from the
+       scanner and before detecting a syntax error.  Thus, state merging
+       (from LALR or IELR) and default reductions corrupt the expected
+       token list.  However, the list is correct for canonical LR with
+       one exception: it will still contain any token that will not be
+       accepted due to an error action in a later state.
+  */
+  if (yytoken != YYEMPTY)
     {
-      int yytype = YYTRANSLATE (yychar);
-      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
-      YYSIZE_T yysize = yysize0;
-      YYSIZE_T yysize1;
-      int yysize_overflow = 0;
-      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
-      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
-      int yyx;
-
-# if 0
-      /* This is so xgettext sees the translatable formats that are
-	 constructed on the fly.  */
-      YY_("syntax error, unexpected %s");
-      YY_("syntax error, unexpected %s, expecting %s");
-      YY_("syntax error, unexpected %s, expecting %s or %s");
-      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
-      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
-# endif
-      char *yyfmt;
-      char const *yyf;
-      static char const yyunexpected[] = "syntax error, unexpected %s";
-      static char const yyexpecting[] = ", expecting %s";
-      static char const yyor[] = " or %s";
-      char yyformat[sizeof yyunexpected
-		    + sizeof yyexpecting - 1
-		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
-		       * (sizeof yyor - 1))];
-      char const *yyprefix = yyexpecting;
-
-      /* Start YYX at -YYN if negative to avoid negative indexes in
-	 YYCHECK.  */
-      int yyxbegin = yyn < 0 ? -yyn : 0;
-
-      /* Stay within bounds of both yycheck and yytname.  */
-      int yychecklim = YYLAST - yyn + 1;
-      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
-      int yycount = 1;
-
-      yyarg[0] = yytname[yytype];
-      yyfmt = yystpcpy (yyformat, yyunexpected);
-
-      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
-	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
-	  {
-	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
-	      {
-		yycount = 1;
-		yysize = yysize0;
-		yyformat[sizeof yyunexpected - 1] = '\0';
-		break;
-	      }
-	    yyarg[yycount++] = yytname[yyx];
-	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
-	    yysize_overflow |= (yysize1 < yysize);
-	    yysize = yysize1;
-	    yyfmt = yystpcpy (yyfmt, yyprefix);
-	    yyprefix = yyor;
-	  }
+      int yyn = yypact[*yyssp];
+      yyarg[yycount++] = yytname[yytoken];
+      if (!yypact_value_is_default (yyn))
+        {
+          /* Start YYX at -YYN if negative to avoid negative indexes in
+             YYCHECK.  In other words, skip the first -YYN actions for
+             this state because they are default actions.  */
+          int yyxbegin = yyn < 0 ? -yyn : 0;
+          /* Stay within bounds of both yycheck and yytname.  */
+          int yychecklim = YYLAST - yyn + 1;
+          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
+          int yyx;
+
+          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
+            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
+                && !yytable_value_is_error (yytable[yyx + yyn]))
+              {
+                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
+                  {
+                    yycount = 1;
+                    yysize = yysize0;
+                    break;
+                  }
+                yyarg[yycount++] = yytname[yyx];
+                yysize1 = yysize + yytnamerr (YY_NULL, yytname[yyx]);
+                if (! (yysize <= yysize1
+                       && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
+                  return 2;
+                yysize = yysize1;
+              }
+        }
+    }
 
-      yyf = YY_(yyformat);
-      yysize1 = yysize + yystrlen (yyf);
-      yysize_overflow |= (yysize1 < yysize);
-      yysize = yysize1;
+  switch (yycount)
+    {
+# define YYCASE_(N, S)                      \
+      case N:                               \
+        yyformat = S;                       \
+      break
+      YYCASE_(0, YY_("syntax error"));
+      YYCASE_(1, YY_("syntax error, unexpected %s"));
+      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
+      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
+      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
+      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
+# undef YYCASE_
+    }
 
-      if (yysize_overflow)
-	return YYSIZE_MAXIMUM;
+  yysize1 = yysize + yystrlen (yyformat);
+  if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
+    return 2;
+  yysize = yysize1;
 
-      if (yyresult)
-	{
-	  /* Avoid sprintf, as that infringes on the user's name space.
-	     Don't have undefined behavior even if the translation
-	     produced a string with the wrong number of "%s"s.  */
-	  char *yyp = yyresult;
-	  int yyi = 0;
-	  while ((*yyp = *yyf) != '\0')
-	    {
-	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
-		{
-		  yyp += yytnamerr (yyp, yyarg[yyi++]);
-		  yyf += 2;
-		}
-	      else
-		{
-		  yyp++;
-		  yyf++;
-		}
-	    }
-	}
-      return yysize;
+  if (*yymsg_alloc < yysize)
+    {
+      *yymsg_alloc = 2 * yysize;
+      if (! (yysize <= *yymsg_alloc
+             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
+        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
+      return 1;
     }
+
+  /* Avoid sprintf, as that infringes on the user's name space.
+     Don't have undefined behavior even if the translation
+     produced a string with the wrong number of "%s"s.  */
+  {
+    char *yyp = *yymsg;
+    int yyi = 0;
+    while ((*yyp = *yyformat) != '\0')
+      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
+        {
+          yyp += yytnamerr (yyp, yyarg[yyi++]);
+          yyformat += 2;
+        }
+      else
+        {
+          yyp++;
+          yyformat++;
+        }
+  }
+  return 0;
 }
 #endif /* YYERROR_VERBOSE */
-
 
 /*-----------------------------------------------.
 | Release the memory associated to this symbol.  |
@@ -1305,7 +1351,7 @@ yydestruct (yymsg, yytype, yyvaluep)
 
   switch (yytype)
     {
-      case 53: /* "choice_entry" */
+      case 57: /* "choice_entry" */
 
 	{
 	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
@@ -1315,7 +1361,7 @@ yydestruct (yymsg, yytype, yyvaluep)
 };
 
 	break;
-      case 59: /* "if_entry" */
+      case 63: /* "if_entry" */
 
 	{
 	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
@@ -1325,7 +1371,7 @@ yydestruct (yymsg, yytype, yyvaluep)
 };
 
 	break;
-      case 65: /* "menu_entry" */
+      case 69: /* "menu_entry" */
 
 	{
 	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
@@ -1341,6 +1387,7 @@ yydestruct (yymsg, yytype, yyvaluep)
     }
 }
 
+
 /* Prevent warnings from -Wmissing-prototypes.  */
 #ifdef YYPARSE_PARAM
 #if defined __STDC__ || defined __cplusplus
@@ -1367,10 +1414,9 @@ YYSTYPE yylval;
 int yynerrs;
 
 
-
-/*-------------------------.
-| yyparse or yypush_parse.  |
-`-------------------------*/
+/*----------.
+| yyparse.  |
+`----------*/
 
 #ifdef YYPARSE_PARAM
 #if (defined __STDC__ || defined __C99__FUNC__ \
@@ -1394,8 +1440,6 @@ yyparse ()
 #endif
 #endif
 {
-
-
     int yystate;
     /* Number of tokens to shift before error messages enabled.  */
     int yyerrstatus;
@@ -1404,7 +1448,7 @@ yyparse ()
        `yyss': related to states.
        `yyvs': related to semantic values.
 
-       Refer to the stacks thru separate pointers, to allow yyoverflow
+       Refer to the stacks through separate pointers, to allow yyoverflow
        to reallocate them elsewhere.  */
 
     /* The state stack.  */
@@ -1550,7 +1594,7 @@ yybackup:
 
   /* First try to decide what to do without reference to lookahead token.  */
   yyn = yypact[yystate];
-  if (yyn == YYPACT_NINF)
+  if (yypact_value_is_default (yyn))
     goto yydefault;
 
   /* Not known => get a lookahead token if don't already have one.  */
@@ -1581,8 +1625,8 @@ yybackup:
   yyn = yytable[yyn];
   if (yyn <= 0)
     {
-      if (yyn == 0 || yyn == YYTABLE_NINF)
-	goto yyerrlab;
+      if (yytable_value_is_error (yyn))
+        goto yyerrlab;
       yyn = -yyn;
       goto yyreduce;
     }
@@ -1637,34 +1681,34 @@ yyreduce:
     {
         case 10:
 
-    { zconf_error("unexpected end statement"); ;}
+    { zconf_error("unexpected end statement"); }
     break;
 
   case 11:
 
-    { zconf_error("unknown statement \"%s\"", (yyvsp[(2) - (4)].string)); ;}
+    { zconf_error("unknown statement \"%s\"", (yyvsp[(2) - (4)].string)); }
     break;
 
   case 12:
 
     {
 	zconf_error("unexpected option \"%s\"", kconf_id_strings + (yyvsp[(2) - (4)].id)->name);
-;}
+}
     break;
 
   case 13:
 
-    { zconf_error("invalid statement"); ;}
+    { zconf_error("invalid statement"); }
     break;
 
   case 28:
 
-    { zconf_error("unknown option \"%s\"", (yyvsp[(1) - (3)].string)); ;}
+    { zconf_error("unknown option \"%s\"", (yyvsp[(1) - (3)].string)); }
     break;
 
   case 29:
 
-    { zconf_error("invalid option"); ;}
+    { zconf_error("invalid option"); }
     break;
 
   case 30:
@@ -1674,7 +1718,7 @@ yyreduce:
 	sym->flags |= SYMBOL_OPTIONAL;
 	menu_add_entry(sym);
 	printd(DEBUG_PARSE, "%s:%d:config %s\n", zconf_curname(), zconf_lineno(), (yyvsp[(2) - (3)].string));
-;}
+}
     break;
 
   case 31:
@@ -1682,7 +1726,7 @@ yyreduce:
     {
 	menu_end_entry();
 	printd(DEBUG_PARSE, "%s:%d:endconfig\n", zconf_curname(), zconf_lineno());
-;}
+}
     break;
 
   case 32:
@@ -1692,7 +1736,7 @@ yyreduce:
 	sym->flags |= SYMBOL_OPTIONAL;
 	menu_add_entry(sym);
 	printd(DEBUG_PARSE, "%s:%d:menuconfig %s\n", zconf_curname(), zconf_lineno(), (yyvsp[(2) - (3)].string));
-;}
+}
     break;
 
   case 33:
@@ -1704,7 +1748,7 @@ yyreduce:
 		zconfprint("warning: menuconfig statement without prompt");
 	menu_end_entry();
 	printd(DEBUG_PARSE, "%s:%d:endconfig\n", zconf_curname(), zconf_lineno());
-;}
+}
     break;
 
   case 41:
@@ -1714,7 +1758,7 @@ yyreduce:
 	printd(DEBUG_PARSE, "%s:%d:type(%u)\n",
 		zconf_curname(), zconf_lineno(),
 		(yyvsp[(1) - (3)].id)->stype);
-;}
+}
     break;
 
   case 42:
@@ -1722,7 +1766,7 @@ yyreduce:
     {
 	menu_add_prompt(P_PROMPT, (yyvsp[(2) - (4)].string), (yyvsp[(3) - (4)].expr));
 	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
-;}
+}
     break;
 
   case 43:
@@ -1734,7 +1778,7 @@ yyreduce:
 	printd(DEBUG_PARSE, "%s:%d:default(%u)\n",
 		zconf_curname(), zconf_lineno(),
 		(yyvsp[(1) - (4)].id)->stype);
-;}
+}
     break;
 
   case 44:
@@ -1742,7 +1786,7 @@ yyreduce:
     {
 	menu_add_symbol(P_SELECT, sym_lookup((yyvsp[(2) - (4)].string), 0), (yyvsp[(3) - (4)].expr));
 	printd(DEBUG_PARSE, "%s:%d:select\n", zconf_curname(), zconf_lineno());
-;}
+}
     break;
 
   case 45:
@@ -1750,7 +1794,7 @@ yyreduce:
     {
 	menu_add_expr(P_RANGE, expr_alloc_comp(E_RANGE,(yyvsp[(2) - (5)].symbol), (yyvsp[(3) - (5)].symbol)), (yyvsp[(4) - (5)].expr));
 	printd(DEBUG_PARSE, "%s:%d:range\n", zconf_curname(), zconf_lineno());
-;}
+}
     break;
 
   case 48:
@@ -1762,17 +1806,17 @@ yyreduce:
 	else
 		zconfprint("warning: ignoring unknown option %s", (yyvsp[(2) - (3)].string));
 	free((yyvsp[(2) - (3)].string));
-;}
+}
     break;
 
   case 49:
 
-    { (yyval.string) = NULL; ;}
+    { (yyval.string) = NULL; }
     break;
 
   case 50:
 
-    { (yyval.string) = (yyvsp[(2) - (2)].string); ;}
+    { (yyval.string) = (yyvsp[(2) - (2)].string); }
     break;
 
   case 51:
@@ -1783,14 +1827,14 @@ yyreduce:
 	menu_add_entry(sym);
 	menu_add_expr(P_CHOICE, NULL, NULL);
 	printd(DEBUG_PARSE, "%s:%d:choice\n", zconf_curname(), zconf_lineno());
-;}
+}
     break;
 
   case 52:
 
     {
 	(yyval.menu) = menu_add_menu();
-;}
+}
     break;
 
   case 53:
@@ -1800,7 +1844,7 @@ yyreduce:
 		menu_end_menu();
 		printd(DEBUG_PARSE, "%s:%d:endchoice\n", zconf_curname(), zconf_lineno());
 	}
-;}
+}
     break;
 
   case 61:
@@ -1808,7 +1852,7 @@ yyreduce:
     {
 	menu_add_prompt(P_PROMPT, (yyvsp[(2) - (4)].string), (yyvsp[(3) - (4)].expr));
 	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
-;}
+}
     break;
 
   case 62:
@@ -1821,7 +1865,7 @@ yyreduce:
 			(yyvsp[(1) - (3)].id)->stype);
 	} else
 		YYERROR;
-;}
+}
     break;
 
   case 63:
@@ -1829,7 +1873,7 @@ yyreduce:
     {
 	current_entry->sym->flags |= SYMBOL_OPTIONAL;
 	printd(DEBUG_PARSE, "%s:%d:optional\n", zconf_curname(), zconf_lineno());
-;}
+}
     break;
 
   case 64:
@@ -1841,7 +1885,7 @@ yyreduce:
 			zconf_curname(), zconf_lineno());
 	} else
 		YYERROR;
-;}
+}
     break;
 
   case 67:
@@ -1851,7 +1895,7 @@ yyreduce:
 	menu_add_entry(NULL);
 	menu_add_dep((yyvsp[(2) - (3)].expr));
 	(yyval.menu) = menu_add_menu();
-;}
+}
     break;
 
   case 68:
@@ -1861,14 +1905,14 @@ yyreduce:
 		menu_end_menu();
 		printd(DEBUG_PARSE, "%s:%d:endif\n", zconf_curname(), zconf_lineno());
 	}
-;}
+}
     break;
 
   case 74:
 
     {
 	menu_add_prompt(P_MENU, (yyvsp[(2) - (3)].string), NULL);
-;}
+}
     break;
 
   case 75:
@@ -1877,14 +1921,14 @@ yyreduce:
 	menu_add_entry(NULL);
 	menu_add_prompt(P_MENU, (yyvsp[(2) - (3)].string), NULL);
 	printd(DEBUG_PARSE, "%s:%d:menu\n", zconf_curname(), zconf_lineno());
-;}
+}
     break;
 
   case 76:
 
     {
 	(yyval.menu) = menu_add_menu();
-;}
+}
     break;
 
   case 77:
@@ -1894,7 +1938,7 @@ yyreduce:
 		menu_end_menu();
 		printd(DEBUG_PARSE, "%s:%d:endmenu\n", zconf_curname(), zconf_lineno());
 	}
-;}
+}
     break;
 
   case 83:
@@ -1902,7 +1946,7 @@ yyreduce:
     {
 	printd(DEBUG_PARSE, "%s:%d:source %s\n", zconf_curname(), zconf_lineno(), (yyvsp[(2) - (3)].string));
 	zconf_nextfile((yyvsp[(2) - (3)].string));
-;}
+}
     break;
 
   case 84:
@@ -1911,14 +1955,14 @@ yyreduce:
 	menu_add_entry(NULL);
 	menu_add_prompt(P_COMMENT, (yyvsp[(2) - (3)].string), NULL);
 	printd(DEBUG_PARSE, "%s:%d:comment\n", zconf_curname(), zconf_lineno());
-;}
+}
     break;
 
   case 85:
 
     {
 	menu_end_entry();
-;}
+}
     break;
 
   case 86:
@@ -1926,14 +1970,14 @@ yyreduce:
     {
 	printd(DEBUG_PARSE, "%s:%d:help\n", zconf_curname(), zconf_lineno());
 	zconf_starthelp();
-;}
+}
     break;
 
   case 87:
 
     {
 	current_entry->help = (yyvsp[(2) - (2)].string);
-;}
+}
     break;
 
   case 92:
@@ -1941,102 +1985,133 @@ yyreduce:
     {
 	menu_add_dep((yyvsp[(3) - (4)].expr));
 	printd(DEBUG_PARSE, "%s:%d:depends on\n", zconf_curname(), zconf_lineno());
-;}
+}
     break;
 
   case 96:
 
     {
 	menu_add_visibility((yyvsp[(2) - (2)].expr));
-;}
+}
     break;
 
   case 98:
 
     {
 	menu_add_prompt(P_PROMPT, (yyvsp[(1) - (2)].string), (yyvsp[(2) - (2)].expr));
-;}
+}
     break;
 
   case 101:
 
-    { (yyval.id) = (yyvsp[(1) - (2)].id); ;}
+    { (yyval.id) = (yyvsp[(1) - (2)].id); }
     break;
 
   case 102:
 
-    { (yyval.id) = (yyvsp[(1) - (2)].id); ;}
+    { (yyval.id) = (yyvsp[(1) - (2)].id); }
     break;
 
   case 103:
 
-    { (yyval.id) = (yyvsp[(1) - (2)].id); ;}
+    { (yyval.id) = (yyvsp[(1) - (2)].id); }
     break;
 
   case 106:
 
-    { (yyval.expr) = NULL; ;}
+    { (yyval.expr) = NULL; }
     break;
 
   case 107:
 
-    { (yyval.expr) = (yyvsp[(2) - (2)].expr); ;}
+    { (yyval.expr) = (yyvsp[(2) - (2)].expr); }
     break;
 
   case 108:
 
-    { (yyval.expr) = expr_alloc_symbol((yyvsp[(1) - (1)].symbol)); ;}
+    { (yyval.expr) = expr_alloc_symbol((yyvsp[(1) - (1)].symbol)); }
     break;
 
   case 109:
 
-    { (yyval.expr) = expr_alloc_comp(E_EQUAL, (yyvsp[(1) - (3)].symbol), (yyvsp[(3) - (3)].symbol)); ;}
+    { (yyval.expr) = expr_alloc_comp(E_LTH, (yyvsp[(1) - (3)].symbol), (yyvsp[(3) - (3)].symbol)); }
     break;
 
   case 110:
 
-    { (yyval.expr) = expr_alloc_comp(E_UNEQUAL, (yyvsp[(1) - (3)].symbol), (yyvsp[(3) - (3)].symbol)); ;}
+    { (yyval.expr) = expr_alloc_comp(E_LEQ, (yyvsp[(1) - (3)].symbol), (yyvsp[(3) - (3)].symbol)); }
     break;
 
   case 111:
 
-    { (yyval.expr) = (yyvsp[(2) - (3)].expr); ;}
+    { (yyval.expr) = expr_alloc_comp(E_GTH, (yyvsp[(1) - (3)].symbol), (yyvsp[(3) - (3)].symbol)); }
     break;
 
   case 112:
 
-    { (yyval.expr) = expr_alloc_one(E_NOT, (yyvsp[(2) - (2)].expr)); ;}
+    { (yyval.expr) = expr_alloc_comp(E_GEQ, (yyvsp[(1) - (3)].symbol), (yyvsp[(3) - (3)].symbol)); }
     break;
 
   case 113:
 
-    { (yyval.expr) = expr_alloc_two(E_OR, (yyvsp[(1) - (3)].expr), (yyvsp[(3) - (3)].expr)); ;}
+    { (yyval.expr) = expr_alloc_comp(E_EQUAL, (yyvsp[(1) - (3)].symbol), (yyvsp[(3) - (3)].symbol)); }
     break;
 
   case 114:
 
-    { (yyval.expr) = expr_alloc_two(E_AND, (yyvsp[(1) - (3)].expr), (yyvsp[(3) - (3)].expr)); ;}
+    { (yyval.expr) = expr_alloc_comp(E_UNEQUAL, (yyvsp[(1) - (3)].symbol), (yyvsp[(3) - (3)].symbol)); }
     break;
 
   case 115:
 
-    { (yyval.symbol) = sym_lookup((yyvsp[(1) - (1)].string), 0); free((yyvsp[(1) - (1)].string)); ;}
+    { (yyval.expr) = (yyvsp[(2) - (3)].expr); }
     break;
 
   case 116:
 
-    { (yyval.symbol) = sym_lookup((yyvsp[(1) - (1)].string), SYMBOL_CONST); free((yyvsp[(1) - (1)].string)); ;}
+    { (yyval.expr) = expr_alloc_one(E_NOT, (yyvsp[(2) - (2)].expr)); }
     break;
 
   case 117:
 
-    { (yyval.string) = NULL; ;}
+    { (yyval.expr) = expr_alloc_two(E_OR, (yyvsp[(1) - (3)].expr), (yyvsp[(3) - (3)].expr)); }
+    break;
+
+  case 118:
+
+    { (yyval.expr) = expr_alloc_two(E_AND, (yyvsp[(1) - (3)].expr), (yyvsp[(3) - (3)].expr)); }
+    break;
+
+  case 119:
+
+    { (yyval.symbol) = sym_lookup((yyvsp[(1) - (1)].string), 0); free((yyvsp[(1) - (1)].string)); }
+    break;
+
+  case 120:
+
+    { (yyval.symbol) = sym_lookup((yyvsp[(1) - (1)].string), SYMBOL_CONST); free((yyvsp[(1) - (1)].string)); }
+    break;
+
+  case 121:
+
+    { (yyval.string) = NULL; }
     break;
 
 
 
       default: break;
     }
+  /* User semantic actions sometimes alter yychar, and that requires
+     that yytoken be updated with the new translation.  We take the
+     approach of translating immediately before every use of yytoken.
+     One alternative is translating here after every semantic action,
+     but that translation would be missed if the semantic action invokes
+     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
+     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
+     incorrect destructor might then be invoked immediately.  In the
+     case of YYERROR or YYBACKUP, subsequent parser actions might lead
+     to an incorrect destructor call or verbose syntax error message
+     before the lookahead is translated.  */
   YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);
 
   YYPOPSTACK (yylen);
@@ -2064,6 +2139,10 @@ yyreduce:
 | yyerrlab -- here on detecting error |
 `------------------------------------*/
 yyerrlab:
+  /* Make sure we have latest lookahead translation.  See comments at
+     user semantic actions for why this is necessary.  */
+  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);
+
   /* If not already recovering from an error, report this error.  */
   if (!yyerrstatus)
     {
@@ -2071,37 +2150,36 @@ yyerrlab:
 #if ! YYERROR_VERBOSE
       yyerror (YY_("syntax error"));
 #else
+# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
+                                        yyssp, yytoken)
       {
-	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
-	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
-	  {
-	    YYSIZE_T yyalloc = 2 * yysize;
-	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
-	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
-	    if (yymsg != yymsgbuf)
-	      YYSTACK_FREE (yymsg);
-	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
-	    if (yymsg)
-	      yymsg_alloc = yyalloc;
-	    else
-	      {
-		yymsg = yymsgbuf;
-		yymsg_alloc = sizeof yymsgbuf;
-	      }
-	  }
-
-	if (0 < yysize && yysize <= yymsg_alloc)
-	  {
-	    (void) yysyntax_error (yymsg, yystate, yychar);
-	    yyerror (yymsg);
-	  }
-	else
-	  {
-	    yyerror (YY_("syntax error"));
-	    if (yysize != 0)
-	      goto yyexhaustedlab;
-	  }
+        char const *yymsgp = YY_("syntax error");
+        int yysyntax_error_status;
+        yysyntax_error_status = YYSYNTAX_ERROR;
+        if (yysyntax_error_status == 0)
+          yymsgp = yymsg;
+        else if (yysyntax_error_status == 1)
+          {
+            if (yymsg != yymsgbuf)
+              YYSTACK_FREE (yymsg);
+            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
+            if (!yymsg)
+              {
+                yymsg = yymsgbuf;
+                yymsg_alloc = sizeof yymsgbuf;
+                yysyntax_error_status = 2;
+              }
+            else
+              {
+                yysyntax_error_status = YYSYNTAX_ERROR;
+                yymsgp = yymsg;
+              }
+          }
+        yyerror (yymsgp);
+        if (yysyntax_error_status == 2)
+          goto yyexhaustedlab;
       }
+# undef YYSYNTAX_ERROR
 #endif
     }
 
@@ -2160,7 +2238,7 @@ yyerrlab1:
   for (;;)
     {
       yyn = yypact[yystate];
-      if (yyn != YYPACT_NINF)
+      if (!yypact_value_is_default (yyn))
 	{
 	  yyn += YYTERROR;
 	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
@@ -2207,7 +2285,7 @@ yyabortlab:
   yyresult = 1;
   goto yyreturn;
 
-#if !defined(yyoverflow) || YYERROR_VERBOSE
+#if !defined yyoverflow || YYERROR_VERBOSE
 /*-------------------------------------------------.
 | yyexhaustedlab -- memory exhaustion comes here.  |
 `-------------------------------------------------*/
@@ -2219,8 +2297,13 @@ yyexhaustedlab:
 
 yyreturn:
   if (yychar != YYEMPTY)
-     yydestruct ("Cleanup: discarding lookahead",
-		 yytoken, &yylval);
+    {
+      /* Make sure we have latest lookahead translation.  See comments at
+         user semantic actions for why this is necessary.  */
+      yytoken = YYTRANSLATE (yychar);
+      yydestruct ("Cleanup: discarding lookahead",
+                  yytoken, &yylval);
+    }
   /* Do not reclaim the symbols of the rule which action triggered
      this YYABORT or YYACCEPT.  */
   YYPOPSTACK (yylen);
@@ -2256,9 +2339,6 @@ void conf_parse(const char *name)
 
 	sym_init();
 	_menu_init();
-	modules_sym = sym_lookup(NULL, 0);
-	modules_sym->type = S_BOOLEAN;
-	modules_sym->flags |= SYMBOL_AUTO;
 	rootmenu.prompt = menu_add_prompt(P_MENU, "Linux Kernel Configuration", NULL);
 
 	if (getenv("ZCONF_DEBUG"))
@@ -2266,12 +2346,8 @@ void conf_parse(const char *name)
 	zconfparse();
 	if (zconfnerrs)
 		exit(1);
-	if (!modules_sym->prop) {
-		struct property *prop;
-
-		prop = prop_alloc(P_DEFAULT, modules_sym);
-		prop->expr = expr_alloc_symbol(sym_lookup("MODULES", 0));
-	}
+	if (!modules_sym)
+		modules_sym = sym_find( "n" );
 
 	rootmenu.prompt->text = _(rootmenu.prompt->text);
 	rootmenu.prompt->text = sym_expand_string_value(rootmenu.prompt->text);
@@ -2280,7 +2356,7 @@ void conf_parse(const char *name)
 	for_all_symbols(i, sym) {
 		if (sym_check_deps(sym))
 			zconfnerrs++;
-        }
+	}
 	if (zconfnerrs)
 		exit(1);
 	sym_set_change_count(1);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in

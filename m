Return-Path: <SRS0=hnMY=WB=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC89C0650F
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9102087B
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfHEMIx (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:08:53 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:20688 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEMIx (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 5 Aug 2019 08:08:53 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id D9A23A1649;
        Mon,  5 Aug 2019 14:08:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id gcnC-QTGZ7zu; Mon,  5 Aug 2019 14:08:16 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>,
        Anthony Wong <yp@anthonywong.net>
Subject: [PATCH 12/12] kconfig: Update to KConfig to version from kernel 4.17
Date:   Mon,  5 Aug 2019 14:07:04 +0200
Message-Id: <20190805120704.13128-13-hauke@hauke-m.de>
In-Reply-To: <20190805120704.13128-1-hauke@hauke-m.de>
References: <20190805120704.13128-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This updates the KConfig system used in backports to the version from
kernel 4.17. In kernel 4.18 some bigger changes to the KConfig system
were introduced which are harder to backport, so start with using this
older version.

This version now generates the zconf.lex.c and zconf.tab.c files from
the original sources, newer kernel versions will delete these files in
a make clean, after that they are now regenerated. We do not ship them
by default any more, so we need lex and yacc.

The Makefile was not copied from the mainline kernel but this is written
specifically for the backports project.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Anthony Wong <yp@anthonywong.net>
---
 backport/.gitignore                       |    2 -
 backport/kconf/.gitignore                 |   17 +
 backport/kconf/Makefile                   |    8 +
 backport/kconf/conf.c                     |  110 +-
 backport/kconf/confdata.c                 |   10 +-
 backport/kconf/expr.c                     |  193 +-
 backport/kconf/expr.h                     |   93 +-
 backport/kconf/kconf_id.c                 |   53 +
 backport/kconf/list.h                     |    1 +
 backport/kconf/lkc.h                      |    6 +-
 backport/kconf/lkc_proto.h                |    3 +-
 backport/kconf/lxdialog/.gitignore        |    4 +
 backport/kconf/lxdialog/BIG.FAT.WARNING   |    4 +
 backport/kconf/lxdialog/check-lxdialog.sh |    4 +-
 backport/kconf/mconf.c                    |    2 +-
 backport/kconf/menu.c                     |  195 +-
 backport/kconf/symbol.c                   |   82 +-
 backport/kconf/util.c                     |   26 +-
 backport/kconf/zconf.hash.c               |  297 ---
 backport/kconf/zconf.l                    |  372 ++++
 backport/kconf/zconf.lex.c                | 2473 ---------------------
 backport/kconf/zconf.tab.c                | 2471 --------------------
 backport/kconf/zconf.y                    |  782 +++++++
 23 files changed, 1792 insertions(+), 5416 deletions(-)
 create mode 100644 backport/kconf/.gitignore
 create mode 100644 backport/kconf/kconf_id.c
 create mode 100644 backport/kconf/lxdialog/.gitignore
 create mode 100644 backport/kconf/lxdialog/BIG.FAT.WARNING
 delete mode 100644 backport/kconf/zconf.hash.c
 create mode 100644 backport/kconf/zconf.l
 delete mode 100644 backport/kconf/zconf.lex.c
 delete mode 100644 backport/kconf/zconf.tab.c
 create mode 100644 backport/kconf/zconf.y

diff --git a/backport/.gitignore b/backport/.gitignore
index c6cf6ce3..83054b63 100644
--- a/backport/.gitignore
+++ b/backport/.gitignore
@@ -14,8 +14,6 @@ Kconfig.versions
 modules.order
 backport-include/backport/autoconf.h
 modules
-kconf/mconf
-kconf/conf
 .tmp_versions
 Module.symvers
 *.mod.c
diff --git a/backport/kconf/.gitignore b/backport/kconf/.gitignore
new file mode 100644
index 00000000..2da579ed
--- /dev/null
+++ b/backport/kconf/.gitignore
@@ -0,0 +1,17 @@
+#
+# Generated files
+#
+*.moc
+gconf.glade.h
+*.pot
+*.mo
+
+#
+# configuration programs
+#
+conf
+mconf
+nconf
+qconf
+gconf
+kxgettext
diff --git a/backport/kconf/Makefile b/backport/kconf/Makefile
index 9edd957a..2004c44f 100644
--- a/backport/kconf/Makefile
+++ b/backport/kconf/Makefile
@@ -13,3 +13,11 @@ mconf: mconf.o zconf.tab.o $(LXDIALOG)
 .PHONY: clean
 clean:
 	@rm -f mconf conf *.o lxdialog/*.o
+
+zconf.tab.c: zconf.lex.c
+
+%.tab.c: %.y
+	$(YACC) -o$@ -t -l $<
+
+%.lex.c: %.l
+	$(LEX) -o$@ -L $<
diff --git a/backport/kconf/conf.c b/backport/kconf/conf.c
index 866369f1..283eeeda 100644
--- a/backport/kconf/conf.c
+++ b/backport/kconf/conf.c
@@ -20,11 +20,10 @@
 
 static void conf(struct menu *menu);
 static void check_conf(struct menu *menu);
-static void xfgets(char *str, int size, FILE *in);
 
 enum input_mode {
 	oldaskconfig,
-	silentoldconfig,
+	syncconfig,
 	oldconfig,
 	allnoconfig,
 	allyesconfig,
@@ -35,11 +34,11 @@ enum input_mode {
 	savedefconfig,
 	listnewconfig,
 	olddefconfig,
-} input_mode = oldaskconfig;
+};
+static enum input_mode input_mode = oldaskconfig;
 
 static int indent = 1;
 static int tty_stdio;
-static int valid_stdin = 1;
 static int sync_kconfig;
 static int conf_cnt;
 static char line[PATH_MAX];
@@ -72,14 +71,14 @@ static void strip(char *str)
 		*p-- = 0;
 }
 
-static void check_stdin(void)
+/* Helper function to facilitate fgets() by Jean Sacren. */
+static void xfgets(char *str, int size, FILE *in)
 {
-	if (!valid_stdin) {
-		printf(_("aborted!\n\n"));
-		printf(_("Console input/output is redirected. "));
-		printf(_("Run 'make oldconfig' to update configuration.\n\n"));
-		exit(1);
-	}
+	if (!fgets(str, size, in))
+		fprintf(stderr, "\nError in reading or end of file.\n");
+
+	if (!tty_stdio)
+		printf("%s", str);
 }
 
 static int conf_askvalue(struct symbol *sym, const char *def)
@@ -101,18 +100,15 @@ static int conf_askvalue(struct symbol *sym, const char *def)
 
 	switch (input_mode) {
 	case oldconfig:
-	case silentoldconfig:
+	case syncconfig:
 		if (sym_has_value(sym)) {
 			printf("%s\n", def);
 			return 0;
 		}
-		check_stdin();
 		/* fall through */
 	case oldaskconfig:
 		fflush(stdout);
 		xfgets(line, sizeof(line), stdin);
-		if (!tty_stdio)
-			printf("\n");
 		return 1;
 	default:
 		break;
@@ -192,9 +188,7 @@ static int conf_sym(struct menu *menu)
 			printf("/m");
 		if (oldval != yes && sym_tristate_within_range(sym, yes))
 			printf("/y");
-		if (menu_has_help(menu))
-			printf("/?");
-		printf("] ");
+		printf("/?] ");
 		if (!conf_askvalue(sym, sym_get_string_value(sym)))
 			return 0;
 		strip(line);
@@ -296,19 +290,15 @@ static int conf_choice(struct menu *menu)
 			printf("[1]: 1\n");
 			goto conf_childs;
 		}
-		printf("[1-%d", cnt);
-		if (menu_has_help(menu))
-			printf("?");
-		printf("]: ");
+		printf("[1-%d?]: ", cnt);
 		switch (input_mode) {
 		case oldconfig:
-		case silentoldconfig:
+		case syncconfig:
 			if (!is_new) {
 				cnt = def;
 				printf("%d\n", cnt);
 				break;
 			}
-			check_stdin();
 			/* fall through */
 		case oldaskconfig:
 			fflush(stdout);
@@ -368,10 +358,11 @@ static void conf(struct menu *menu)
 
 		switch (prop->type) {
 		case P_MENU:
-			if ((input_mode == silentoldconfig ||
-			     input_mode == listnewconfig ||
-			     input_mode == olddefconfig) &&
-			    rootEntry != menu) {
+			/*
+			 * Except in oldaskconfig mode, we show only menus that
+			 * contain new symbols.
+			 */
+			if (input_mode != oldaskconfig && rootEntry != menu) {
 				check_conf(menu);
 				return;
 			}
@@ -431,10 +422,20 @@ static void check_conf(struct menu *menu)
 		if (sym_is_changable(sym) ||
 		    (sym_is_choice(sym) && sym_get_tristate_value(sym) == yes)) {
 			if (input_mode == listnewconfig) {
-				if (sym->name && !sym_is_choice_value(sym)) {
-					printf("%s%s\n", CONFIG_, sym->name);
+				if (sym->name) {
+					const char *str;
+
+					if (sym->type == S_STRING) {
+						str = sym_get_string_value(sym);
+						str = sym_escape_string_value(str);
+						printf("%s%s=%s\n", CONFIG_, sym->name, str);
+						free((void *)str);
+					} else {
+						str = sym_get_string_value(sym);
+						printf("%s%s=%s\n", CONFIG_, sym->name, str);
+					}
 				}
-			} else if (input_mode != olddefconfig) {
+			} else {
 				if (!conf_cnt++)
 					printf(_("*\n* Restart config...\n*\n"));
 				rootEntry = menu_get_parent_menu(menu);
@@ -450,7 +451,7 @@ static void check_conf(struct menu *menu)
 static struct option long_opts[] = {
 	{"oldaskconfig",    no_argument,       NULL, oldaskconfig},
 	{"oldconfig",       no_argument,       NULL, oldconfig},
-	{"silentoldconfig", no_argument,       NULL, silentoldconfig},
+	{"syncconfig",      no_argument,       NULL, syncconfig},
 	{"defconfig",       optional_argument, NULL, defconfig},
 	{"savedefconfig",   required_argument, NULL, savedefconfig},
 	{"allnoconfig",     no_argument,       NULL, allnoconfig},
@@ -477,8 +478,9 @@ static void conf_usage(const char *progname)
 	printf("  --listnewconfig         List new options\n");
 	printf("  --oldaskconfig          Start a new configuration using a line-oriented program\n");
 	printf("  --oldconfig             Update a configuration using a provided .config as base\n");
-	printf("  --silentoldconfig       Same as oldconfig, but quietly, additionally update deps\n");
-	printf("  --olddefconfig          Same as silentoldconfig but sets new symbols to their default value\n");
+	printf("  --syncconfig            Similar to oldconfig but generates configuration in\n"
+	       "                          include/{generated/,config/}\n");
+	printf("  --olddefconfig          Same as oldconfig but sets new symbols to their default value\n");
 	printf("  --oldnoconfig           An alias of olddefconfig\n");
 	printf("  --defconfig <file>      New config with default defined in <file>\n");
 	printf("  --savedefconfig <file>  Save the minimal current configuration to <file>\n");
@@ -500,7 +502,7 @@ int main(int ac, char **av)
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 
-	tty_stdio = isatty(0) && isatty(1) && isatty(2);
+	tty_stdio = isatty(0) && isatty(1);
 
 	while ((opt = getopt_long(ac, av, "s", long_opts, NULL)) != -1) {
 		if (opt == 's') {
@@ -509,7 +511,7 @@ int main(int ac, char **av)
 		}
 		input_mode = (enum input_mode)opt;
 		switch (opt) {
-		case silentoldconfig:
+		case syncconfig:
 			sync_kconfig = 1;
 			break;
 		case defconfig:
@@ -557,7 +559,7 @@ int main(int ac, char **av)
 		}
 	}
 	if (ac == optind) {
-		printf(_("%s: Kconfig file missing\n"), av[0]);
+		fprintf(stderr, _("%s: Kconfig file missing\n"), av[0]);
 		conf_usage(progname);
 		exit(1);
 	}
@@ -582,14 +584,16 @@ int main(int ac, char **av)
 		if (!defconfig_file)
 			defconfig_file = conf_get_default_confname();
 		if (conf_read(defconfig_file)) {
-			printf(_("***\n"
-				"*** Can't find default configuration \"%s\"!\n"
-				"***\n"), defconfig_file);
+			fprintf(stderr,
+				_("***\n"
+				  "*** Can't find default configuration \"%s\"!\n"
+				  "***\n"),
+				defconfig_file);
 			exit(1);
 		}
 		break;
 	case savedefconfig:
-	case silentoldconfig:
+	case syncconfig:
 	case oldaskconfig:
 	case oldconfig:
 	case listnewconfig:
@@ -642,7 +646,6 @@ int main(int ac, char **av)
 				return 1;
 			}
 		}
-		valid_stdin = tty_stdio;
 	}
 
 	switch (input_mode) {
@@ -670,24 +673,24 @@ int main(int ac, char **av)
 	case oldaskconfig:
 		rootEntry = &rootmenu;
 		conf(&rootmenu);
-		input_mode = silentoldconfig;
+		input_mode = oldconfig;
 		/* fall through */
 	case oldconfig:
 	case listnewconfig:
-	case olddefconfig:
-	case silentoldconfig:
+	case syncconfig:
 		/* Update until a loop caused no more changes */
 		do {
 			conf_cnt = 0;
 			check_conf(&rootmenu);
-		} while (conf_cnt &&
-			 (input_mode != listnewconfig &&
-			  input_mode != olddefconfig));
+		} while (conf_cnt);
+		break;
+	case olddefconfig:
+	default:
 		break;
 	}
 
 	if (sync_kconfig) {
-		/* silentoldconfig is used during the build so we shall update autoconf.
+		/* syncconfig is used during the build so we shall update autoconf.
 		 * All other commands are only used to generate a config.
 		 */
 		if (conf_get_changed() && conf_write(NULL)) {
@@ -712,12 +715,3 @@ int main(int ac, char **av)
 	}
 	return 0;
 }
-
-/*
- * Helper function to facilitate fgets() by Jean Sacren.
- */
-void xfgets(char *str, int size, FILE *in)
-{
-	if (fgets(str, size, in) == NULL)
-		fprintf(stderr, "\nError in reading or end of file.\n");
-}
diff --git a/backport/kconf/confdata.c b/backport/kconf/confdata.c
index 297b079a..df26c7b0 100644
--- a/backport/kconf/confdata.c
+++ b/backport/kconf/confdata.c
@@ -28,7 +28,7 @@ static void conf_message(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 
 static const char *conf_filename;
-static int conf_lineno, conf_warnings, conf_unsaved;
+static int conf_lineno, conf_warnings;
 
 const char conf_defname[] = "arch/$ARCH/defconfig";
 
@@ -178,7 +178,7 @@ static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
 	case S_HEX:
 	done:
 		if (sym_string_valid(sym, p)) {
-			sym->def[def].val = strdup(p);
+			sym->def[def].val = xstrdup(p);
 			sym->flags |= def_flags;
 		} else {
 			if (def != S_DEF_AUTO)
@@ -201,7 +201,7 @@ static int add_byte(int c, char **lineptr, size_t slen, size_t *n)
 	if (new_size > *n) {
 		new_size += LINE_GROWTH - 1;
 		new_size *= 2;
-		nline = realloc(*lineptr, new_size);
+		nline = xrealloc(*lineptr, new_size);
 		if (!nline)
 			return -1;
 
@@ -290,7 +290,6 @@ load:
 	conf_filename = name;
 	conf_lineno = 0;
 	conf_warnings = 0;
-	conf_unsaved = 0;
 
 	def_flags = SYMBOL_DEF << def;
 	for_all_symbols(i, sym) {
@@ -409,6 +408,7 @@ setsym:
 int conf_read(const char *name)
 {
 	struct symbol *sym;
+	int conf_unsaved = 0;
 	int i;
 
 	sym_set_change_count(0);
@@ -1123,7 +1123,7 @@ void set_all_choice_values(struct symbol *csym)
 bool conf_set_all_new_symbols(enum conf_def_mode mode)
 {
 	struct symbol *sym, *csym;
-	int i, cnt, pby, pty, ptm;	/* pby: probability of boolean  = y
+	int i, cnt, pby, pty, ptm;	/* pby: probability of bool     = y
 					 * pty: probability of tristate = y
 					 * ptm: probability of tristate = m
 					 */
diff --git a/backport/kconf/expr.c b/backport/kconf/expr.c
index cbf4996d..e1a39e90 100644
--- a/backport/kconf/expr.c
+++ b/backport/kconf/expr.c
@@ -94,7 +94,7 @@ struct expr *expr_copy(const struct expr *org)
 		e->right.expr = expr_copy(org->right.expr);
 		break;
 	default:
-		printf("can't copy type %d\n", e->type);
+		fprintf(stderr, "can't copy type %d\n", e->type);
 		free(e);
 		e = NULL;
 		break;
@@ -113,7 +113,7 @@ void expr_free(struct expr *e)
 		break;
 	case E_NOT:
 		expr_free(e->left.expr);
-		return;
+		break;
 	case E_EQUAL:
 	case E_GEQ:
 	case E_GTH:
@@ -127,7 +127,7 @@ void expr_free(struct expr *e)
 		expr_free(e->right.expr);
 		break;
 	default:
-		printf("how to free type %d?\n", e->type);
+		fprintf(stderr, "how to free type %d?\n", e->type);
 		break;
 	}
 	free(e);
@@ -138,8 +138,18 @@ static int trans_count;
 #define e1 (*ep1)
 #define e2 (*ep2)
 
+/*
+ * expr_eliminate_eq() helper.
+ *
+ * Walks the two expression trees given in 'ep1' and 'ep2'. Any node that does
+ * not have type 'type' (E_OR/E_AND) is considered a leaf, and is compared
+ * against all other leaves. Two equal leaves are both replaced with either 'y'
+ * or 'n' as appropriate for 'type', to be eliminated later.
+ */
 static void __expr_eliminate_eq(enum expr_type type, struct expr **ep1, struct expr **ep2)
 {
+	/* Recurse down to leaves */
+
 	if (e1->type == type) {
 		__expr_eliminate_eq(type, &e1->left.expr, &e2);
 		__expr_eliminate_eq(type, &e1->right.expr, &e2);
@@ -150,12 +160,18 @@ static void __expr_eliminate_eq(enum expr_type type, struct expr **ep1, struct e
 		__expr_eliminate_eq(type, &e1, &e2->right.expr);
 		return;
 	}
+
+	/* e1 and e2 are leaves. Compare them. */
+
 	if (e1->type == E_SYMBOL && e2->type == E_SYMBOL &&
 	    e1->left.sym == e2->left.sym &&
 	    (e1->left.sym == &symbol_yes || e1->left.sym == &symbol_no))
 		return;
 	if (!expr_eq(e1, e2))
 		return;
+
+	/* e1 and e2 are equal leaves. Prepare them for elimination. */
+
 	trans_count++;
 	expr_free(e1); expr_free(e2);
 	switch (type) {
@@ -172,6 +188,35 @@ static void __expr_eliminate_eq(enum expr_type type, struct expr **ep1, struct e
 	}
 }
 
+/*
+ * Rewrites the expressions 'ep1' and 'ep2' to remove operands common to both.
+ * Example reductions:
+ *
+ *	ep1: A && B           ->  ep1: y
+ *	ep2: A && B && C      ->  ep2: C
+ *
+ *	ep1: A || B           ->  ep1: n
+ *	ep2: A || B || C      ->  ep2: C
+ *
+ *	ep1: A && (B && FOO)  ->  ep1: FOO
+ *	ep2: (BAR && B) && A  ->  ep2: BAR
+ *
+ *	ep1: A && (B || C)    ->  ep1: y
+ *	ep2: (C || B) && A    ->  ep2: y
+ *
+ * Comparisons are done between all operands at the same "level" of && or ||.
+ * For example, in the expression 'e1 && (e2 || e3) && (e4 || e5)', the
+ * following operands will be compared:
+ *
+ *	- 'e1', 'e2 || e3', and 'e4 || e5', against each other
+ *	- e2 against e3
+ *	- e4 against e5
+ *
+ * Parentheses are irrelevant within a single level. 'e1 && (e2 && e3)' and
+ * '(e1 && e2) && e3' are both a single level.
+ *
+ * See __expr_eliminate_eq() as well.
+ */
 void expr_eliminate_eq(struct expr **ep1, struct expr **ep2)
 {
 	if (!e1 || !e2)
@@ -197,6 +242,12 @@ void expr_eliminate_eq(struct expr **ep1, struct expr **ep2)
 #undef e1
 #undef e2
 
+/*
+ * Returns true if 'e1' and 'e2' are equal, after minor simplification. Two
+ * &&/|| expressions are considered equal if every operand in one expression
+ * equals some operand in the other (operands do not need to appear in the same
+ * order), recursively.
+ */
 static int expr_eq(struct expr *e1, struct expr *e2)
 {
 	int res, old_count;
@@ -243,6 +294,17 @@ static int expr_eq(struct expr *e1, struct expr *e2)
 	return 0;
 }
 
+/*
+ * Recursively performs the following simplifications in-place (as well as the
+ * corresponding simplifications with swapped operands):
+ *
+ *	expr && n  ->  n
+ *	expr && y  ->  expr
+ *	expr || n  ->  expr
+ *	expr || y  ->  y
+ *
+ * Returns the optimized expression.
+ */
 static struct expr *expr_eliminate_yn(struct expr *e)
 {
 	struct expr *tmp;
@@ -516,12 +578,21 @@ static struct expr *expr_join_and(struct expr *e1, struct expr *e2)
 	return NULL;
 }
 
+/*
+ * expr_eliminate_dups() helper.
+ *
+ * Walks the two expression trees given in 'ep1' and 'ep2'. Any node that does
+ * not have type 'type' (E_OR/E_AND) is considered a leaf, and is compared
+ * against all other leaves to look for simplifications.
+ */
 static void expr_eliminate_dups1(enum expr_type type, struct expr **ep1, struct expr **ep2)
 {
 #define e1 (*ep1)
 #define e2 (*ep2)
 	struct expr *tmp;
 
+	/* Recurse down to leaves */
+
 	if (e1->type == type) {
 		expr_eliminate_dups1(type, &e1->left.expr, &e2);
 		expr_eliminate_dups1(type, &e1->right.expr, &e2);
@@ -532,6 +603,9 @@ static void expr_eliminate_dups1(enum expr_type type, struct expr **ep1, struct
 		expr_eliminate_dups1(type, &e1, &e2->right.expr);
 		return;
 	}
+
+	/* e1 and e2 are leaves. Compare and process them. */
+
 	if (e1 == e2)
 		return;
 
@@ -568,6 +642,17 @@ static void expr_eliminate_dups1(enum expr_type type, struct expr **ep1, struct
 #undef e2
 }
 
+/*
+ * Rewrites 'e' in-place to remove ("join") duplicate and other redundant
+ * operands.
+ *
+ * Example simplifications:
+ *
+ *	A || B || A    ->  A || B
+ *	A && B && A=y  ->  A=y && B
+ *
+ * Returns the deduplicated expression.
+ */
 struct expr *expr_eliminate_dups(struct expr *e)
 {
 	int oldcount;
@@ -584,6 +669,7 @@ struct expr *expr_eliminate_dups(struct expr *e)
 			;
 		}
 		if (!trans_count)
+			/* No simplifications done in this pass. We're done */
 			break;
 		e = expr_eliminate_yn(e);
 	}
@@ -591,6 +677,12 @@ struct expr *expr_eliminate_dups(struct expr *e)
 	return e;
 }
 
+/*
+ * Performs various simplifications involving logical operators and
+ * comparisons.
+ *
+ * Allocates and returns a new expression.
+ */
 struct expr *expr_transform(struct expr *e)
 {
 	struct expr *tmp;
@@ -805,6 +897,20 @@ bool expr_depends_symbol(struct expr *dep, struct symbol *sym)
  	return false;
 }
 
+/*
+ * Inserts explicit comparisons of type 'type' to symbol 'sym' into the
+ * expression 'e'.
+ *
+ * Examples transformations for type == E_UNEQUAL, sym == &symbol_no:
+ *
+ *	A              ->  A!=n
+ *	!A             ->  A=n
+ *	A && B         ->  !(A=n || B=n)
+ *	A || B         ->  !(A=n && B=n)
+ *	A && (B || C)  ->  !(A=n || (B=n && C=n))
+ *
+ * Allocates and returns a new expression.
+ */
 struct expr *expr_trans_compare(struct expr *e, enum expr_type type, struct symbol *sym)
 {
 	struct expr *e1, *e2;
@@ -893,7 +999,10 @@ static enum string_value_kind expr_parse_string(const char *str,
 	switch (type) {
 	case S_BOOLEAN:
 	case S_TRISTATE:
-		return k_string;
+		val->s = !strcmp(str, "n") ? 0 :
+			 !strcmp(str, "m") ? 1 :
+			 !strcmp(str, "y") ? 2 : -1;
+		return k_signed;
 	case S_INT:
 		val->s = strtoll(str, &tail, 10);
 		kind = k_signed;
@@ -1028,49 +1137,9 @@ static int expr_compare_type(enum expr_type t1, enum expr_type t2)
 	return 0;
 }
 
-static inline struct expr *
-expr_get_leftmost_symbol(const struct expr *e)
-{
-
-	if (e == NULL)
-		return NULL;
-
-	while (e->type != E_SYMBOL)
-		e = e->left.expr;
-
-	return expr_copy(e);
-}
-
-/*
- * Given expression `e1' and `e2', returns the leaf of the longest
- * sub-expression of `e1' not containing 'e2.
- */
-struct expr *expr_simplify_unmet_dep(struct expr *e1, struct expr *e2)
-{
-	struct expr *ret;
-
-	switch (e1->type) {
-	case E_OR:
-		return expr_alloc_and(
-		    expr_simplify_unmet_dep(e1->left.expr, e2),
-		    expr_simplify_unmet_dep(e1->right.expr, e2));
-	case E_AND: {
-		struct expr *e;
-		e = expr_alloc_and(expr_copy(e1), expr_copy(e2));
-		e = expr_eliminate_dups(e);
-		ret = (!expr_eq(e, e1)) ? e1 : NULL;
-		expr_free(e);
-		break;
-		}
-	default:
-		ret = e1;
-		break;
-	}
-
-	return expr_get_leftmost_symbol(ret);
-}
-
-void expr_print(struct expr *e, void (*fn)(void *, struct symbol *, const char *), void *data, int prevtoken)
+void expr_print(struct expr *e,
+		void (*fn)(void *, struct symbol *, const char *),
+		void *data, int prevtoken)
 {
 	if (!e) {
 		fn(data, NULL, "y");
@@ -1204,3 +1273,33 @@ void expr_gstr_print(struct expr *e, struct gstr *gs)
 {
 	expr_print(e, expr_print_gstr_helper, gs, E_NONE);
 }
+
+/*
+ * Transform the top level "||" tokens into newlines and prepend each
+ * line with a minus. This makes expressions much easier to read.
+ * Suitable for reverse dependency expressions.
+ */
+static void expr_print_revdep(struct expr *e,
+			      void (*fn)(void *, struct symbol *, const char *),
+			      void *data, tristate pr_type, const char **title)
+{
+	if (e->type == E_OR) {
+		expr_print_revdep(e->left.expr, fn, data, pr_type, title);
+		expr_print_revdep(e->right.expr, fn, data, pr_type, title);
+	} else if (expr_calc_value(e) == pr_type) {
+		if (*title) {
+			fn(data, NULL, *title);
+			*title = NULL;
+		}
+
+		fn(data, NULL, "  - ");
+		expr_print(e, fn, data, E_NONE);
+		fn(data, NULL, "\n");
+	}
+}
+
+void expr_gstr_print_revdep(struct expr *e, struct gstr *gs,
+			    tristate pr_type, const char *title)
+{
+	expr_print_revdep(e, expr_print_gstr_helper, gs, pr_type, &title);
+}
diff --git a/backport/kconf/expr.h b/backport/kconf/expr.h
index a73f762c..94a383b2 100644
--- a/backport/kconf/expr.h
+++ b/backport/kconf/expr.h
@@ -74,17 +74,60 @@ enum {
 	S_DEF_COUNT
 };
 
+/*
+ * Represents a configuration symbol.
+ *
+ * Choices are represented as a special kind of symbol and have the
+ * SYMBOL_CHOICE bit set in 'flags'.
+ */
 struct symbol {
+	/* The next symbol in the same bucket in the symbol hash table */
 	struct symbol *next;
+
+	/* The name of the symbol, e.g. "FOO" for 'config FOO' */
 	char *name;
+
+	/* S_BOOLEAN, S_TRISTATE, ... */
 	enum symbol_type type;
+
+	/*
+	 * The calculated value of the symbol. The SYMBOL_VALID bit is set in
+	 * 'flags' when this is up to date. Note that this value might differ
+	 * from the user value set in e.g. a .config file, due to visibility.
+	 */
 	struct symbol_value curr;
+
+	/*
+	 * Values for the symbol provided from outside. def[S_DEF_USER] holds
+	 * the .config value.
+	 */
 	struct symbol_value def[S_DEF_COUNT];
+
+	/*
+	 * An upper bound on the tristate value the user can set for the symbol
+	 * if it is a boolean or tristate. Calculated from prompt dependencies,
+	 * which also inherit dependencies from enclosing menus, choices, and
+	 * ifs. If 'n', the user value will be ignored.
+	 *
+	 * Symbols lacking prompts always have visibility 'n'.
+	 */
 	tristate visible;
+
+	/* SYMBOL_* flags */
 	int flags;
+
+	/* List of properties. See prop_type. */
 	struct property *prop;
+
+	/* Dependencies from enclosing menus, choices, and ifs */
 	struct expr_value dir_dep;
+
+	/* Reverse dependencies through being selected by other symbols */
 	struct expr_value rev_dep;
+
+	/*
+	 * "Weak" reverse dependencies through being implied by other symbols
+	 */
 	struct expr_value implied;
 };
 
@@ -133,7 +176,7 @@ enum prop_type {
 	P_UNKNOWN,
 	P_PROMPT,   /* prompt "foo prompt" or "BAZ Value" */
 	P_COMMENT,  /* text associated with a comment */
-	P_MENU,     /* prompt associated with a menuconfig option */
+	P_MENU,     /* prompt associated with a menu or menuconfig symbol */
 	P_DEFAULT,  /* default y */
 	P_CHOICE,   /* choice value */
 	P_SELECT,   /* select BAR */
@@ -166,22 +209,67 @@ struct property {
 	for (st = sym->prop; st; st = st->next) \
 		if (st->text)
 
+/*
+ * Represents a node in the menu tree, as seen in e.g. menuconfig (though used
+ * for all front ends). Each symbol, menu, etc. defined in the Kconfig files
+ * gets a node. A symbol defined in multiple locations gets one node at each
+ * location.
+ */
 struct menu {
+	/* The next menu node at the same level */
 	struct menu *next;
+
+	/* The parent menu node, corresponding to e.g. a menu or choice */
 	struct menu *parent;
+
+	/* The first child menu node, for e.g. menus and choices */
 	struct menu *list;
+
+	/*
+	 * The symbol associated with the menu node. Choices are implemented as
+	 * a special kind of symbol. NULL for menus, comments, and ifs.
+	 */
 	struct symbol *sym;
+
+	/*
+	 * The prompt associated with the node. This holds the prompt for a
+	 * symbol as well as the text for a menu or comment, along with the
+	 * type (P_PROMPT, P_MENU, etc.)
+	 */
 	struct property *prompt;
+
+	/*
+	 * 'visible if' dependencies. If more than one is given, they will be
+	 * ANDed together.
+	 */
 	struct expr *visibility;
+
+	/*
+	 * Ordinary dependencies from e.g. 'depends on' and 'if', ANDed
+	 * together
+	 */
 	struct expr *dep;
+
+	/* MENU_* flags */
 	unsigned int flags;
+
+	/* Any help text associated with the node */
 	char *help;
+
+	/* The location where the menu node appears in the Kconfig files */
 	struct file *file;
 	int lineno;
+
+	/* For use by front ends that need to store auxiliary data */
 	void *data;
 };
 
+/*
+ * Set on a menu node when the corresponding symbol changes state in some way.
+ * Can be checked by front ends.
+ */
 #define MENU_CHANGED		0x0001
+
 #define MENU_ROOT		0x0002
 
 struct jump_key {
@@ -217,11 +305,12 @@ struct expr *expr_transform(struct expr *e);
 int expr_contains_symbol(struct expr *dep, struct symbol *sym);
 bool expr_depends_symbol(struct expr *dep, struct symbol *sym);
 struct expr *expr_trans_compare(struct expr *e, enum expr_type type, struct symbol *sym);
-struct expr *expr_simplify_unmet_dep(struct expr *e1, struct expr *e2);
 
 void expr_fprint(struct expr *e, FILE *out);
 struct gstr; /* forward */
 void expr_gstr_print(struct expr *e, struct gstr *gs);
+void expr_gstr_print_revdep(struct expr *e, struct gstr *gs,
+			    tristate pr_type, const char *title);
 
 static inline int expr_is_yes(struct expr *e)
 {
diff --git a/backport/kconf/kconf_id.c b/backport/kconf/kconf_id.c
new file mode 100644
index 00000000..3ea9c5f9
--- /dev/null
+++ b/backport/kconf/kconf_id.c
@@ -0,0 +1,53 @@
+
+static struct kconf_id kconf_id_array[] = {
+	{ "mainmenu",		T_MAINMENU,		TF_COMMAND },
+	{ "menu",		T_MENU,			TF_COMMAND },
+	{ "endmenu",		T_ENDMENU,		TF_COMMAND },
+	{ "source",		T_SOURCE,		TF_COMMAND },
+	{ "choice",		T_CHOICE,		TF_COMMAND },
+	{ "endchoice",		T_ENDCHOICE,		TF_COMMAND },
+	{ "comment",		T_COMMENT,		TF_COMMAND },
+	{ "config",		T_CONFIG,		TF_COMMAND },
+	{ "menuconfig",		T_MENUCONFIG,		TF_COMMAND },
+	{ "help",		T_HELP,			TF_COMMAND },
+	{ "---help---",		T_HELP,			TF_COMMAND },
+	{ "if",			T_IF,			TF_COMMAND|TF_PARAM },
+	{ "endif",		T_ENDIF,		TF_COMMAND },
+	{ "depends",		T_DEPENDS,		TF_COMMAND },
+	{ "optional",		T_OPTIONAL,		TF_COMMAND },
+	{ "default",		T_DEFAULT,		TF_COMMAND, S_UNKNOWN },
+	{ "prompt",		T_PROMPT,		TF_COMMAND },
+	{ "tristate",		T_TYPE,			TF_COMMAND, S_TRISTATE },
+	{ "def_tristate",	T_DEFAULT,		TF_COMMAND, S_TRISTATE },
+	{ "bool",		T_TYPE,			TF_COMMAND, S_BOOLEAN },
+	{ "def_bool",		T_DEFAULT,		TF_COMMAND, S_BOOLEAN },
+	{ "int",		T_TYPE,			TF_COMMAND, S_INT },
+	{ "hex",		T_TYPE,			TF_COMMAND, S_HEX },
+	{ "string",		T_TYPE,			TF_COMMAND, S_STRING },
+	{ "select",		T_SELECT,		TF_COMMAND },
+	{ "imply",		T_IMPLY,		TF_COMMAND },
+	{ "range",		T_RANGE,		TF_COMMAND },
+	{ "visible",		T_VISIBLE,		TF_COMMAND },
+	{ "option",		T_OPTION,		TF_COMMAND },
+	{ "on",			T_ON,			TF_PARAM },
+	{ "modules",		T_OPT_MODULES,		TF_OPTION },
+	{ "defconfig_list",	T_OPT_DEFCONFIG_LIST,	TF_OPTION },
+	{ "env",		T_OPT_ENV,		TF_OPTION },
+	{ "allnoconfig_y",	T_OPT_ALLNOCONFIG_Y,	TF_OPTION },
+};
+
+#define KCONF_ID_ARRAY_SIZE (sizeof(kconf_id_array)/sizeof(struct kconf_id))
+
+static const struct kconf_id *kconf_id_lookup(register const char *str, register unsigned int len)
+{
+	int i;
+
+	for (i = 0; i < KCONF_ID_ARRAY_SIZE; i++) {
+		struct kconf_id *id = kconf_id_array+i;
+		int l = strlen(id->name);
+
+		if (len == l && !memcmp(str, id->name, len))
+			return id;
+	}
+	return NULL;
+}
diff --git a/backport/kconf/list.h b/backport/kconf/list.h
index 2cf23f00..45cb237a 100644
--- a/backport/kconf/list.h
+++ b/backport/kconf/list.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef LIST_H
 #define LIST_H
 
diff --git a/backport/kconf/lkc.h b/backport/kconf/lkc.h
index 91ca126e..f4394af6 100644
--- a/backport/kconf/lkc.h
+++ b/backport/kconf/lkc.h
@@ -62,12 +62,13 @@ enum conf_def_mode {
 #define T_OPT_ALLNOCONFIG_Y	4
 
 struct kconf_id {
-	int name;
+	const char *name;
 	int token;
 	unsigned int flags;
 	enum symbol_type stype;
 };
 
+extern int yylineno;
 void zconfdump(FILE *out);
 void zconf_starthelp(void);
 FILE *zconf_fopen(const char *name);
@@ -100,7 +101,6 @@ void menu_warn(struct menu *menu, const char *fmt, ...);
 struct menu *menu_add_menu(void);
 void menu_end_menu(void);
 void menu_add_entry(struct symbol *sym);
-void menu_end_entry(void);
 void menu_add_dep(struct expr *dep);
 void menu_add_visibility(struct expr *dep);
 struct property *menu_add_prompt(enum prop_type type, char *prompt, struct expr *dep);
@@ -115,6 +115,8 @@ struct file *file_lookup(const char *name);
 int file_write_dep(const char *name);
 void *xmalloc(size_t size);
 void *xcalloc(size_t nmemb, size_t size);
+void *xrealloc(void *p, size_t size);
+char *xstrdup(const char *s);
 
 struct gstr {
 	size_t len;
diff --git a/backport/kconf/lkc_proto.h b/backport/kconf/lkc_proto.h
index d5398718..9dc8abfb 100644
--- a/backport/kconf/lkc_proto.h
+++ b/backport/kconf/lkc_proto.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #include <stdarg.h>
 
 /* confdata.c */
@@ -30,7 +31,7 @@ extern struct symbol * symbol_hash[SYMBOL_HASHSIZE];
 
 struct symbol * sym_lookup(const char *name, int flags);
 struct symbol * sym_find(const char *name);
-const char * sym_expand_string_value(const char *in);
+char *sym_expand_string_value(const char *in);
 const char * sym_escape_string_value(const char *in);
 struct symbol ** sym_re_search(const char *pattern);
 const char * sym_type_name(enum symbol_type type);
diff --git a/backport/kconf/lxdialog/.gitignore b/backport/kconf/lxdialog/.gitignore
new file mode 100644
index 00000000..90b08ff0
--- /dev/null
+++ b/backport/kconf/lxdialog/.gitignore
@@ -0,0 +1,4 @@
+#
+# Generated files
+#
+lxdialog
diff --git a/backport/kconf/lxdialog/BIG.FAT.WARNING b/backport/kconf/lxdialog/BIG.FAT.WARNING
new file mode 100644
index 00000000..a8999d82
--- /dev/null
+++ b/backport/kconf/lxdialog/BIG.FAT.WARNING
@@ -0,0 +1,4 @@
+This is NOT the official version of dialog.  This version has been
+significantly modified from the original.  It is for use by the Linux
+kernel configuration script.  Please do not bother Savio Lam with 
+questions about this program.
diff --git a/backport/kconf/lxdialog/check-lxdialog.sh b/backport/kconf/lxdialog/check-lxdialog.sh
index 5075ebf2..6c0bcd9c 100755
--- a/backport/kconf/lxdialog/check-lxdialog.sh
+++ b/backport/kconf/lxdialog/check-lxdialog.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
 # Check ncurses compatibility
 
 # What library to link
@@ -54,7 +55,8 @@ EOF
 	    echo " *** required header files."                            1>&2
 	    echo " *** 'make menuconfig' requires the ncurses libraries." 1>&2
 	    echo " *** "                                                  1>&2
-	    echo " *** Install ncurses (ncurses-devel) and try again."    1>&2
+	    echo " *** Install ncurses (ncurses-devel or libncurses-dev " 1>&2
+	    echo " *** depending on your distribution) and try again."    1>&2
 	    echo " *** "                                                  1>&2
 	    exit 1
 	fi
diff --git a/backport/kconf/mconf.c b/backport/kconf/mconf.c
index 315ce2c7..c829be8b 100644
--- a/backport/kconf/mconf.c
+++ b/backport/kconf/mconf.c
@@ -246,7 +246,7 @@ search_help[] = N_(
 	"  Selected by: BAR [=n]\n"
 	"-----------------------------------------------------------------\n"
 	"o The line 'Type:' shows the type of the configuration option for\n"
-	"  this symbol (boolean, tristate, string, ...)\n"
+	"  this symbol (bool, tristate, string, ...)\n"
 	"o The line 'Prompt:' shows the text used in the menu structure for\n"
 	"  this symbol\n"
 	"o The 'Defined at' line tells at what file / line number the symbol\n"
diff --git a/backport/kconf/menu.c b/backport/kconf/menu.c
index e9357931..5c5c1374 100644
--- a/backport/kconf/menu.c
+++ b/backport/kconf/menu.c
@@ -62,13 +62,8 @@ void menu_add_entry(struct symbol *sym)
 		menu_add_symbol(P_SYMBOL, sym, NULL);
 }
 
-void menu_end_entry(void)
-{
-}
-
 struct menu *menu_add_menu(void)
 {
-	menu_end_entry();
 	last_entry_ptr = &current_entry->list;
 	return current_menu = current_entry;
 }
@@ -79,19 +74,23 @@ void menu_end_menu(void)
 	current_menu = current_menu->parent;
 }
 
-static struct expr *menu_check_dep(struct expr *e)
+/*
+ * Rewrites 'm' to 'm' && MODULES, so that it evaluates to 'n' when running
+ * without modules
+ */
+static struct expr *rewrite_m(struct expr *e)
 {
 	if (!e)
 		return e;
 
 	switch (e->type) {
 	case E_NOT:
-		e->left.expr = menu_check_dep(e->left.expr);
+		e->left.expr = rewrite_m(e->left.expr);
 		break;
 	case E_OR:
 	case E_AND:
-		e->left.expr = menu_check_dep(e->left.expr);
-		e->right.expr = menu_check_dep(e->right.expr);
+		e->left.expr = rewrite_m(e->left.expr);
+		e->right.expr = rewrite_m(e->right.expr);
 		break;
 	case E_SYMBOL:
 		/* change 'm' into 'm' && MODULES */
@@ -106,7 +105,7 @@ static struct expr *menu_check_dep(struct expr *e)
 
 void menu_add_dep(struct expr *dep)
 {
-	current_entry->dep = expr_alloc_and(current_entry->dep, menu_check_dep(dep));
+	current_entry->dep = expr_alloc_and(current_entry->dep, dep);
 }
 
 void menu_set_type(int type)
@@ -131,7 +130,7 @@ static struct property *menu_add_prop(enum prop_type type, char *prompt, struct
 
 	prop->menu = current_entry;
 	prop->expr = expr;
-	prop->visible.expr = menu_check_dep(dep);
+	prop->visible.expr = dep;
 
 	if (prompt) {
 		if (isspace(*prompt)) {
@@ -213,6 +212,7 @@ void menu_add_option(int token, char *arg)
 			sym_defconfig_list = current_entry->sym;
 		else if (sym_defconfig_list != current_entry->sym)
 			zconf_error("trying to redefine defconfig symbol");
+		sym_defconfig_list->flags |= SYMBOL_AUTO;
 		break;
 	case T_OPT_ENV:
 		prop_add_env(arg);
@@ -252,6 +252,16 @@ static void sym_check_prop(struct symbol *sym)
 					    "'%s': number is invalid",
 					    sym->name);
 			}
+			if (sym_is_choice(sym)) {
+				struct property *choice_prop =
+					sym_get_choice_prop(sym2);
+
+				if (!choice_prop ||
+				    prop_get_symbol(choice_prop) != sym)
+					prop_warn(prop,
+						  "choice default symbol '%s' is not contained in the choice",
+						  sym2->name);
+			}
 			break;
 		case P_SELECT:
 		case P_IMPLY:
@@ -260,13 +270,13 @@ static void sym_check_prop(struct symbol *sym)
 			if (sym->type != S_BOOLEAN && sym->type != S_TRISTATE)
 				prop_warn(prop,
 				    "config symbol '%s' uses %s, but is "
-				    "not boolean or tristate", sym->name, use);
+				    "not bool or tristate", sym->name, use);
 			else if (sym2->type != S_UNKNOWN &&
 				 sym2->type != S_BOOLEAN &&
 				 sym2->type != S_TRISTATE)
 				prop_warn(prop,
 				    "'%s' has wrong type. '%s' only "
-				    "accept arguments of boolean and "
+				    "accept arguments of bool and "
 				    "tristate type", sym2->name, use);
 			break;
 		case P_RANGE:
@@ -292,6 +302,11 @@ void menu_finalize(struct menu *parent)
 
 	sym = parent->sym;
 	if (parent->list) {
+		/*
+		 * This menu node has children. We (recursively) process them
+		 * and propagate parent dependencies before moving on.
+		 */
+
 		if (sym && sym_is_choice(sym)) {
 			if (sym->type == S_UNKNOWN) {
 				/* find the first choice value to find out choice type */
@@ -309,30 +324,83 @@ void menu_finalize(struct menu *parent)
 				if (menu->sym && menu->sym->type == S_UNKNOWN)
 					menu_set_type(sym->type);
 			}
+
+			/*
+			 * Use the choice itself as the parent dependency of
+			 * the contained items. This turns the mode of the
+			 * choice into an upper bound on the visibility of the
+			 * choice value symbols.
+			 */
 			parentdep = expr_alloc_symbol(sym);
 		} else if (parent->prompt)
+			/* Menu node for 'menu' */
 			parentdep = parent->prompt->visible.expr;
 		else
+			/* Menu node for 'if' */
 			parentdep = parent->dep;
 
+		/* For each child menu node... */
 		for (menu = parent->list; menu; menu = menu->next) {
-			basedep = expr_transform(menu->dep);
+			/*
+			 * Propagate parent dependencies to the child menu
+			 * node, also rewriting and simplifying expressions
+			 */
+			basedep = rewrite_m(menu->dep);
+			basedep = expr_transform(basedep);
 			basedep = expr_alloc_and(expr_copy(parentdep), basedep);
 			basedep = expr_eliminate_dups(basedep);
 			menu->dep = basedep;
+
 			if (menu->sym)
+				/*
+				 * Note: For symbols, all prompts are included
+				 * too in the symbol's own property list
+				 */
 				prop = menu->sym->prop;
 			else
+				/*
+				 * For non-symbol menu nodes, we just need to
+				 * handle the prompt
+				 */
 				prop = menu->prompt;
+
+			/* For each property... */
 			for (; prop; prop = prop->next) {
 				if (prop->menu != menu)
+					/*
+					 * Two possibilities:
+					 *
+					 * 1. The property lacks dependencies
+					 *    and so isn't location-specific,
+					 *    e.g. an 'option'
+					 *
+					 * 2. The property belongs to a symbol
+					 *    defined in multiple locations and
+					 *    is from some other location. It
+					 *    will be handled there in that
+					 *    case.
+					 *
+					 * Skip the property.
+					 */
 					continue;
-				dep = expr_transform(prop->visible.expr);
+
+				/*
+				 * Propagate parent dependencies to the
+				 * property's condition, rewriting and
+				 * simplifying expressions at the same time
+				 */
+				dep = rewrite_m(prop->visible.expr);
+				dep = expr_transform(dep);
 				dep = expr_alloc_and(expr_copy(basedep), dep);
 				dep = expr_eliminate_dups(dep);
 				if (menu->sym && menu->sym->type != S_TRISTATE)
 					dep = expr_trans_bool(dep);
 				prop->visible.expr = dep;
+
+				/*
+				 * Handle selects and implies, which modify the
+				 * dependencies of the selected/implied symbol
+				 */
 				if (prop->type == P_SELECT) {
 					struct symbol *es = prop_get_symbol(prop);
 					es->rev_dep.expr = expr_alloc_or(es->rev_dep.expr,
@@ -344,34 +412,81 @@ void menu_finalize(struct menu *parent)
 				}
 			}
 		}
+
+		if (sym && sym_is_choice(sym))
+			expr_free(parentdep);
+
+		/*
+		 * Recursively process children in the same fashion before
+		 * moving on
+		 */
 		for (menu = parent->list; menu; menu = menu->next)
 			menu_finalize(menu);
 	} else if (sym) {
+		/*
+		 * Automatic submenu creation. If sym is a symbol and A, B, C,
+		 * ... are consecutive items (symbols, menus, ifs, etc.) that
+		 * all depend on sym, then the following menu structure is
+		 * created:
+		 *
+		 *	sym
+		 *	 +-A
+		 *	 +-B
+		 *	 +-C
+		 *	 ...
+		 *
+		 * This also works recursively, giving the following structure
+		 * if A is a symbol and B depends on A:
+		 *
+		 *	sym
+		 *	 +-A
+		 *	 | +-B
+		 *	 +-C
+		 *	 ...
+		 */
+
 		basedep = parent->prompt ? parent->prompt->visible.expr : NULL;
 		basedep = expr_trans_compare(basedep, E_UNEQUAL, &symbol_no);
 		basedep = expr_eliminate_dups(expr_transform(basedep));
+
+		/* Examine consecutive elements after sym */
 		last_menu = NULL;
 		for (menu = parent->next; menu; menu = menu->next) {
 			dep = menu->prompt ? menu->prompt->visible.expr : menu->dep;
 			if (!expr_contains_symbol(dep, sym))
+				/* No dependency, quit */
 				break;
 			if (expr_depends_symbol(dep, sym))
+				/* Absolute dependency, put in submenu */
 				goto next;
+
+			/*
+			 * Also consider it a dependency on sym if our
+			 * dependencies contain sym and are a "superset" of
+			 * sym's dependencies, e.g. '(sym || Q) && R' when sym
+			 * depends on R.
+			 *
+			 * Note that 'R' might be from an enclosing menu or if,
+			 * making this a more common case than it might seem.
+			 */
 			dep = expr_trans_compare(dep, E_UNEQUAL, &symbol_no);
 			dep = expr_eliminate_dups(expr_transform(dep));
 			dep2 = expr_copy(basedep);
 			expr_eliminate_eq(&dep, &dep2);
 			expr_free(dep);
 			if (!expr_is_yes(dep2)) {
+				/* Not superset, quit */
 				expr_free(dep2);
 				break;
 			}
+			/* Superset, put in submenu */
 			expr_free(dep2);
 		next:
 			menu_finalize(menu);
 			menu->parent = parent;
 			last_menu = menu;
 		}
+		expr_free(basedep);
 		if (last_menu) {
 			parent->list = parent->next;
 			parent->next = last_menu->next;
@@ -420,6 +535,35 @@ void menu_finalize(struct menu *parent)
 			*ep = expr_alloc_one(E_LIST, NULL);
 			(*ep)->right.sym = menu->sym;
 		}
+
+		/*
+		 * This code serves two purposes:
+		 *
+		 * (1) Flattening 'if' blocks, which do not specify a submenu
+		 *     and only add dependencies.
+		 *
+		 *     (Automatic submenu creation might still create a submenu
+		 *     from an 'if' before this code runs.)
+		 *
+		 * (2) "Undoing" any automatic submenus created earlier below
+		 *     promptless symbols.
+		 *
+		 * Before:
+		 *
+		 *	A
+		 *	if ... (or promptless symbol)
+		 *	 +-B
+		 *	 +-C
+		 *	D
+		 *
+		 * After:
+		 *
+		 *	A
+		 *	if ... (or promptless symbol)
+		 *	B
+		 *	C
+		 *	D
+		 */
 		if (menu->list && (!menu->prompt || !menu->prompt->text)) {
 			for (last_menu = menu->list; ; last_menu = last_menu->next) {
 				last_menu->parent = parent;
@@ -444,6 +588,15 @@ void menu_finalize(struct menu *parent)
 		sym->flags |= SYMBOL_WARNED;
 	}
 
+	/*
+	 * For non-optional choices, add a reverse dependency (corresponding to
+	 * a select) of '<visibility> && m'. This prevents the user from
+	 * setting the choice mode to 'n' when the choice is visible.
+	 *
+	 * This would also work for non-choice symbols, but only non-optional
+	 * choices clear SYMBOL_OPTIONAL as of writing. Choices are implemented
+	 * as a type of symbol.
+	 */
 	if (sym && !sym_is_optional(sym) && parent->prompt) {
 		sym->rev_dep.expr = expr_alloc_or(sym->rev_dep.expr,
 				expr_alloc_and(parent->prompt->visible.expr,
@@ -675,16 +828,16 @@ static void get_symbol_str(struct gstr *r, struct symbol *sym,
 
 	get_symbol_props_str(r, sym, P_SELECT, _("  Selects: "));
 	if (sym->rev_dep.expr) {
-		str_append(r, _("  Selected by: "));
-		expr_gstr_print(sym->rev_dep.expr, r);
-		str_append(r, "\n");
+		expr_gstr_print_revdep(sym->rev_dep.expr, r, yes, "  Selected by [y]:\n");
+		expr_gstr_print_revdep(sym->rev_dep.expr, r, mod, "  Selected by [m]:\n");
+		expr_gstr_print_revdep(sym->rev_dep.expr, r, no, "  Selected by [n]:\n");
 	}
 
 	get_symbol_props_str(r, sym, P_IMPLY, _("  Implies: "));
 	if (sym->implied.expr) {
-		str_append(r, _("  Implied by: "));
-		expr_gstr_print(sym->implied.expr, r);
-		str_append(r, "\n");
+		expr_gstr_print_revdep(sym->implied.expr, r, yes, "  Implied by [y]:\n");
+		expr_gstr_print_revdep(sym->implied.expr, r, mod, "  Implied by [m]:\n");
+		expr_gstr_print_revdep(sym->implied.expr, r, no, "  Implied by [n]:\n");
 	}
 
 	str_append(r, "\n\n");
diff --git a/backport/kconf/symbol.c b/backport/kconf/symbol.c
index 20136ffe..f0b2e3b3 100644
--- a/backport/kconf/symbol.c
+++ b/backport/kconf/symbol.c
@@ -77,7 +77,7 @@ const char *sym_type_name(enum symbol_type type)
 {
 	switch (type) {
 	case S_BOOLEAN:
-		return "boolean";
+		return "bool";
 	case S_TRISTATE:
 		return "tristate";
 	case S_INT:
@@ -183,7 +183,7 @@ static void sym_validate_range(struct symbol *sym)
 		sprintf(str, "%lld", val2);
 	else
 		sprintf(str, "0x%llx", val2);
-	sym->curr.val = strdup(str);
+	sym->curr.val = xstrdup(str);
 }
 
 static void sym_set_changed(struct symbol *sym)
@@ -243,7 +243,7 @@ static void sym_calc_visibility(struct symbol *sym)
 	tri = yes;
 	if (sym->dir_dep.expr)
 		tri = expr_calc_value(sym->dir_dep.expr);
-	if (tri == mod)
+	if (tri == mod && sym_get_type(sym) == S_BOOLEAN)
 		tri = yes;
 	if (sym->dir_dep.tri != tri) {
 		sym->dir_dep.tri = tri;
@@ -333,6 +333,27 @@ static struct symbol *sym_calc_choice(struct symbol *sym)
 	return def_sym;
 }
 
+static void sym_warn_unmet_dep(struct symbol *sym)
+{
+	struct gstr gs = str_new();
+
+	str_printf(&gs,
+		   "\nWARNING: unmet direct dependencies detected for %s\n",
+		   sym->name);
+	str_printf(&gs,
+		   "  Depends on [%c]: ",
+		   sym->dir_dep.tri == mod ? 'm' : 'n');
+	expr_gstr_print(sym->dir_dep.expr, &gs);
+	str_printf(&gs, "\n");
+
+	expr_gstr_print_revdep(sym->rev_dep.expr, &gs, yes,
+			       "  Selected by [y]:\n");
+	expr_gstr_print_revdep(sym->rev_dep.expr, &gs, mod,
+			       "  Selected by [m]:\n");
+
+	fputs(str_get(&gs), stderr);
+}
+
 void sym_calc_value(struct symbol *sym)
 {
 	struct symbol_value newval, oldval;
@@ -371,11 +392,13 @@ void sym_calc_value(struct symbol *sym)
 		sym->curr.tri = no;
 		return;
 	}
-	if (!sym_is_choice_value(sym))
-		sym->flags &= ~SYMBOL_WRITE;
+	sym->flags &= ~SYMBOL_WRITE;
 
 	sym_calc_visibility(sym);
 
+	if (sym->visible != no)
+		sym->flags |= SYMBOL_WRITE;
+
 	/* set default if recursively called */
 	sym->curr = newval;
 
@@ -390,7 +413,6 @@ void sym_calc_value(struct symbol *sym)
 				/* if the symbol is visible use the user value
 				 * if available, otherwise try the default value
 				 */
-				sym->flags |= SYMBOL_WRITE;
 				if (sym_has_value(sym)) {
 					newval.tri = EXPR_AND(sym->def[S_DEF_USER].tri,
 							      sym->visible);
@@ -402,9 +424,10 @@ void sym_calc_value(struct symbol *sym)
 			if (!sym_is_choice(sym)) {
 				prop = sym_get_default_prop(sym);
 				if (prop) {
-					sym->flags |= SYMBOL_WRITE;
 					newval.tri = EXPR_AND(expr_calc_value(prop->expr),
 							      prop->visible.tri);
+					if (newval.tri != no)
+						sym->flags |= SYMBOL_WRITE;
 				}
 				if (sym->implied.tri != no) {
 					sym->flags |= SYMBOL_WRITE;
@@ -412,18 +435,8 @@ void sym_calc_value(struct symbol *sym)
 				}
 			}
 		calc_newval:
-			if (sym->dir_dep.tri == no && sym->rev_dep.tri != no) {
-				struct expr *e;
-				e = expr_simplify_unmet_dep(sym->rev_dep.expr,
-				    sym->dir_dep.expr);
-				fprintf(stderr, "warning: (");
-				expr_fprint(e, stderr);
-				fprintf(stderr, ") selects %s which has unmet direct dependencies (",
-					sym->name);
-				expr_fprint(sym->dir_dep.expr, stderr);
-				fprintf(stderr, ")\n");
-				expr_free(e);
-			}
+			if (sym->dir_dep.tri < sym->rev_dep.tri)
+				sym_warn_unmet_dep(sym);
 			newval.tri = EXPR_OR(newval.tri, sym->rev_dep.tri);
 		}
 		if (newval.tri == mod &&
@@ -433,12 +446,9 @@ void sym_calc_value(struct symbol *sym)
 	case S_STRING:
 	case S_HEX:
 	case S_INT:
-		if (sym->visible != no) {
-			sym->flags |= SYMBOL_WRITE;
-			if (sym_has_value(sym)) {
-				newval.val = sym->def[S_DEF_USER].val;
-				break;
-			}
+		if (sym->visible != no && sym_has_value(sym)) {
+			newval.val = sym->def[S_DEF_USER].val;
+			break;
 		}
 		prop = sym_get_default_prop(sym);
 		if (prop) {
@@ -851,7 +861,7 @@ struct symbol *sym_lookup(const char *name, int flags)
 				   : !(symbol->flags & (SYMBOL_CONST|SYMBOL_CHOICE))))
 				return symbol;
 		}
-		new_name = strdup(name);
+		new_name = xstrdup(name);
 	} else {
 		new_name = NULL;
 		hash = 0;
@@ -901,12 +911,16 @@ struct symbol *sym_find(const char *name)
  * name to be expanded shall be prefixed by a '$'. Unknown symbol expands to
  * the empty string.
  */
-const char *sym_expand_string_value(const char *in)
+char *sym_expand_string_value(const char *in)
 {
 	const char *src;
 	char *res;
 	size_t reslen;
 
+	/*
+	 * Note: 'in' might come from a token that's about to be
+	 * freed, so make sure to always allocate a new string
+	 */
 	reslen = strlen(in) + 1;
 	res = xmalloc(reslen);
 	res[0] = '\0';
@@ -934,7 +948,7 @@ const char *sym_expand_string_value(const char *in)
 		newlen = strlen(res) + strlen(symval) + strlen(src) + 1;
 		if (newlen > reslen) {
 			reslen = newlen;
-			res = realloc(res, reslen);
+			res = xrealloc(res, reslen);
 		}
 
 		strcat(res, symval);
@@ -1061,7 +1075,7 @@ struct symbol **sym_re_search(const char *pattern)
 	}
 	if (sym_match_arr) {
 		qsort(sym_match_arr, cnt, sizeof(struct sym_match), sym_rel_comp);
-		sym_arr = malloc((cnt+1) * sizeof(struct symbol));
+		sym_arr = malloc((cnt+1) * sizeof(struct symbol *));
 		if (!sym_arr)
 			goto sym_re_search_free;
 		for (i = 0; i < cnt; i++)
@@ -1150,8 +1164,7 @@ static void sym_check_print_recursive(struct symbol *last_sym)
 		if (stack->sym == last_sym)
 			fprintf(stderr, "%s:%d:error: recursive dependency detected!\n",
 				prop->file->name, prop->lineno);
-			fprintf(stderr, "For a resolution refer to Documentation/kbuild/kconfig-language.txt\n");
-			fprintf(stderr, "subsection \"Kconfig recursive dependency limitations\"\n");
+
 		if (stack->expr) {
 			fprintf(stderr, "%s:%d:\tsymbol %s %s value contains %s\n",
 				prop->file->name, prop->lineno,
@@ -1181,6 +1194,11 @@ static void sym_check_print_recursive(struct symbol *last_sym)
 		}
 	}
 
+	fprintf(stderr,
+		"For a resolution refer to Documentation/kbuild/kconfig-language.txt\n"
+		"subsection \"Kconfig recursive dependency limitations\"\n"
+		"\n");
+
 	if (check_top == &cv_stack)
 		dep_stack_remove();
 }
@@ -1215,7 +1233,7 @@ static struct symbol *sym_check_expr_deps(struct expr *e)
 	default:
 		break;
 	}
-	printf("Oops! How to check %d?\n", e->type);
+	fprintf(stderr, "Oops! How to check %d?\n", e->type);
 	return NULL;
 }
 
diff --git a/backport/kconf/util.c b/backport/kconf/util.c
index 0e760424..c6f6e21b 100644
--- a/backport/kconf/util.c
+++ b/backport/kconf/util.c
@@ -14,11 +14,11 @@
 struct file *file_lookup(const char *name)
 {
 	struct file *file;
-	const char *file_name = sym_expand_string_value(name);
+	char *file_name = sym_expand_string_value(name);
 
 	for (file = file_list; file; file = file->next) {
 		if (!strcmp(name, file->name)) {
-			free((void *)file_name);
+			free(file_name);
 			return file;
 		}
 	}
@@ -104,7 +104,7 @@ void str_append(struct gstr *gs, const char *s)
 	if (s) {
 		l = strlen(gs->s) + strlen(s) + 1;
 		if (l > gs->len) {
-			gs->s   = realloc(gs->s, l);
+			gs->s = xrealloc(gs->s, l);
 			gs->len = l;
 		}
 		strcat(gs->s, s);
@@ -145,3 +145,23 @@ void *xcalloc(size_t nmemb, size_t size)
 	fprintf(stderr, "Out of memory.\n");
 	exit(1);
 }
+
+void *xrealloc(void *p, size_t size)
+{
+	p = realloc(p, size);
+	if (p)
+		return p;
+	fprintf(stderr, "Out of memory.\n");
+	exit(1);
+}
+
+char *xstrdup(const char *s)
+{
+	char *p;
+
+	p = strdup(s);
+	if (p)
+		return p;
+	fprintf(stderr, "Out of memory.\n");
+	exit(1);
+}
diff --git a/backport/kconf/zconf.hash.c b/backport/kconf/zconf.hash.c
deleted file mode 100644
index d51b15de..00000000
--- a/backport/kconf/zconf.hash.c
+++ /dev/null
@@ -1,297 +0,0 @@
-/* ANSI-C code produced by gperf version 3.0.4 */
-/* Command-line: gperf -t --output-file scripts/kconfig/zconf.hash.c_shipped -a -C -E -g -k '1,3,$' -p -t scripts/kconfig/zconf.gperf  */
-
-#if !((' ' == 32) && ('!' == 33) && ('"' == 34) && ('#' == 35) \
-      && ('%' == 37) && ('&' == 38) && ('\'' == 39) && ('(' == 40) \
-      && (')' == 41) && ('*' == 42) && ('+' == 43) && (',' == 44) \
-      && ('-' == 45) && ('.' == 46) && ('/' == 47) && ('0' == 48) \
-      && ('1' == 49) && ('2' == 50) && ('3' == 51) && ('4' == 52) \
-      && ('5' == 53) && ('6' == 54) && ('7' == 55) && ('8' == 56) \
-      && ('9' == 57) && (':' == 58) && (';' == 59) && ('<' == 60) \
-      && ('=' == 61) && ('>' == 62) && ('?' == 63) && ('A' == 65) \
-      && ('B' == 66) && ('C' == 67) && ('D' == 68) && ('E' == 69) \
-      && ('F' == 70) && ('G' == 71) && ('H' == 72) && ('I' == 73) \
-      && ('J' == 74) && ('K' == 75) && ('L' == 76) && ('M' == 77) \
-      && ('N' == 78) && ('O' == 79) && ('P' == 80) && ('Q' == 81) \
-      && ('R' == 82) && ('S' == 83) && ('T' == 84) && ('U' == 85) \
-      && ('V' == 86) && ('W' == 87) && ('X' == 88) && ('Y' == 89) \
-      && ('Z' == 90) && ('[' == 91) && ('\\' == 92) && (']' == 93) \
-      && ('^' == 94) && ('_' == 95) && ('a' == 97) && ('b' == 98) \
-      && ('c' == 99) && ('d' == 100) && ('e' == 101) && ('f' == 102) \
-      && ('g' == 103) && ('h' == 104) && ('i' == 105) && ('j' == 106) \
-      && ('k' == 107) && ('l' == 108) && ('m' == 109) && ('n' == 110) \
-      && ('o' == 111) && ('p' == 112) && ('q' == 113) && ('r' == 114) \
-      && ('s' == 115) && ('t' == 116) && ('u' == 117) && ('v' == 118) \
-      && ('w' == 119) && ('x' == 120) && ('y' == 121) && ('z' == 122) \
-      && ('{' == 123) && ('|' == 124) && ('}' == 125) && ('~' == 126))
-/* The character set is not based on ISO-646.  */
-#error "gperf generated tables don't work with this execution character set. Please report a bug to <bug-gnu-gperf@gnu.org>."
-#endif
-
-#line 10 "scripts/kconfig/zconf.gperf"
-struct kconf_id;
-
-static const struct kconf_id *kconf_id_lookup(register const char *str, register unsigned int len);
-/* maximum key range = 71, duplicates = 0 */
-
-#ifdef __GNUC__
-__inline
-#else
-#ifdef __cplusplus
-inline
-#endif
-#endif
-static unsigned int
-kconf_id_hash (register const char *str, register unsigned int len)
-{
-  static const unsigned char asso_values[] =
-    {
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73,  0, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 10, 25, 25,
-       0,  0,  0,  5,  0,  0, 73, 73,  5,  0,
-      10,  5, 45, 73, 20, 20,  0, 15, 15, 73,
-      20,  0, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73, 73, 73, 73, 73,
-      73, 73, 73, 73, 73, 73
-    };
-  register int hval = len;
-
-  switch (hval)
-    {
-      default:
-        hval += asso_values[(unsigned char)str[2]];
-      /*FALLTHROUGH*/
-      case 2:
-      case 1:
-        hval += asso_values[(unsigned char)str[0]];
-        break;
-    }
-  return hval + asso_values[(unsigned char)str[len - 1]];
-}
-
-struct kconf_id_strings_t
-  {
-    char kconf_id_strings_str2[sizeof("if")];
-    char kconf_id_strings_str3[sizeof("int")];
-    char kconf_id_strings_str5[sizeof("endif")];
-    char kconf_id_strings_str7[sizeof("default")];
-    char kconf_id_strings_str8[sizeof("tristate")];
-    char kconf_id_strings_str9[sizeof("endchoice")];
-    char kconf_id_strings_str10[sizeof("---help---")];
-    char kconf_id_strings_str12[sizeof("def_tristate")];
-    char kconf_id_strings_str13[sizeof("def_bool")];
-    char kconf_id_strings_str14[sizeof("defconfig_list")];
-    char kconf_id_strings_str17[sizeof("on")];
-    char kconf_id_strings_str18[sizeof("optional")];
-    char kconf_id_strings_str21[sizeof("option")];
-    char kconf_id_strings_str22[sizeof("endmenu")];
-    char kconf_id_strings_str23[sizeof("mainmenu")];
-    char kconf_id_strings_str25[sizeof("menuconfig")];
-    char kconf_id_strings_str27[sizeof("modules")];
-    char kconf_id_strings_str28[sizeof("allnoconfig_y")];
-    char kconf_id_strings_str29[sizeof("menu")];
-    char kconf_id_strings_str31[sizeof("select")];
-    char kconf_id_strings_str32[sizeof("comment")];
-    char kconf_id_strings_str33[sizeof("env")];
-    char kconf_id_strings_str35[sizeof("range")];
-    char kconf_id_strings_str36[sizeof("choice")];
-    char kconf_id_strings_str39[sizeof("bool")];
-    char kconf_id_strings_str41[sizeof("source")];
-    char kconf_id_strings_str42[sizeof("visible")];
-    char kconf_id_strings_str43[sizeof("hex")];
-    char kconf_id_strings_str46[sizeof("config")];
-    char kconf_id_strings_str47[sizeof("boolean")];
-    char kconf_id_strings_str50[sizeof("imply")];
-    char kconf_id_strings_str51[sizeof("string")];
-    char kconf_id_strings_str54[sizeof("help")];
-    char kconf_id_strings_str56[sizeof("prompt")];
-    char kconf_id_strings_str72[sizeof("depends")];
-  };
-static const struct kconf_id_strings_t kconf_id_strings_contents =
-  {
-    "if",
-    "int",
-    "endif",
-    "default",
-    "tristate",
-    "endchoice",
-    "---help---",
-    "def_tristate",
-    "def_bool",
-    "defconfig_list",
-    "on",
-    "optional",
-    "option",
-    "endmenu",
-    "mainmenu",
-    "menuconfig",
-    "modules",
-    "allnoconfig_y",
-    "menu",
-    "select",
-    "comment",
-    "env",
-    "range",
-    "choice",
-    "bool",
-    "source",
-    "visible",
-    "hex",
-    "config",
-    "boolean",
-    "imply",
-    "string",
-    "help",
-    "prompt",
-    "depends"
-  };
-#define kconf_id_strings ((const char *) &kconf_id_strings_contents)
-#ifdef __GNUC__
-__inline
-#if defined __GNUC_STDC_INLINE__ || defined __GNUC_GNU_INLINE__
-__attribute__ ((__gnu_inline__))
-#endif
-#endif
-const struct kconf_id *
-kconf_id_lookup (register const char *str, register unsigned int len)
-{
-  enum
-    {
-      TOTAL_KEYWORDS = 35,
-      MIN_WORD_LENGTH = 2,
-      MAX_WORD_LENGTH = 14,
-      MIN_HASH_VALUE = 2,
-      MAX_HASH_VALUE = 72
-    };
-
-  static const struct kconf_id wordlist[] =
-    {
-      {-1}, {-1},
-#line 26 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str2,		T_IF,		TF_COMMAND|TF_PARAM},
-#line 37 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str3,		T_TYPE,		TF_COMMAND, S_INT},
-      {-1},
-#line 27 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str5,		T_ENDIF,	TF_COMMAND},
-      {-1},
-#line 30 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str7,	T_DEFAULT,	TF_COMMAND, S_UNKNOWN},
-#line 32 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str8,	T_TYPE,		TF_COMMAND, S_TRISTATE},
-#line 20 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str9,	T_ENDCHOICE,	TF_COMMAND},
-#line 25 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str10,	T_HELP,		TF_COMMAND},
-      {-1},
-#line 33 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str12,	T_DEFAULT,	TF_COMMAND, S_TRISTATE},
-#line 36 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str13,	T_DEFAULT,	TF_COMMAND, S_BOOLEAN},
-#line 47 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str14,	T_OPT_DEFCONFIG_LIST,TF_OPTION},
-      {-1}, {-1},
-#line 45 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str17,		T_ON,		TF_PARAM},
-#line 29 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str18,	T_OPTIONAL,	TF_COMMAND},
-      {-1}, {-1},
-#line 44 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str21,		T_OPTION,	TF_COMMAND},
-#line 17 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str22,	T_ENDMENU,	TF_COMMAND},
-#line 15 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str23,	T_MAINMENU,	TF_COMMAND},
-      {-1},
-#line 23 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str25,	T_MENUCONFIG,	TF_COMMAND},
-      {-1},
-#line 46 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str27,	T_OPT_MODULES,	TF_OPTION},
-#line 49 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str28,	T_OPT_ALLNOCONFIG_Y,TF_OPTION},
-#line 16 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str29,		T_MENU,		TF_COMMAND},
-      {-1},
-#line 40 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str31,		T_SELECT,	TF_COMMAND},
-#line 21 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str32,	T_COMMENT,	TF_COMMAND},
-#line 48 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str33,		T_OPT_ENV,	TF_OPTION},
-      {-1},
-#line 42 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str35,		T_RANGE,	TF_COMMAND},
-#line 19 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str36,		T_CHOICE,	TF_COMMAND},
-      {-1}, {-1},
-#line 34 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str39,		T_TYPE,		TF_COMMAND, S_BOOLEAN},
-      {-1},
-#line 18 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str41,		T_SOURCE,	TF_COMMAND},
-#line 43 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str42,	T_VISIBLE,	TF_COMMAND},
-#line 38 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str43,		T_TYPE,		TF_COMMAND, S_HEX},
-      {-1}, {-1},
-#line 22 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str46,		T_CONFIG,	TF_COMMAND},
-#line 35 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str47,	T_TYPE,		TF_COMMAND, S_BOOLEAN},
-      {-1}, {-1},
-#line 41 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str50,		T_IMPLY,	TF_COMMAND},
-#line 39 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str51,		T_TYPE,		TF_COMMAND, S_STRING},
-      {-1}, {-1},
-#line 24 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str54,		T_HELP,		TF_COMMAND},
-      {-1},
-#line 31 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str56,		T_PROMPT,	TF_COMMAND},
-      {-1}, {-1}, {-1}, {-1}, {-1}, {-1}, {-1}, {-1}, {-1},
-      {-1}, {-1}, {-1}, {-1}, {-1}, {-1},
-#line 28 "scripts/kconfig/zconf.gperf"
-      {(int)(long)&((struct kconf_id_strings_t *)0)->kconf_id_strings_str72,	T_DEPENDS,	TF_COMMAND}
-    };
-
-  if (len <= MAX_WORD_LENGTH && len >= MIN_WORD_LENGTH)
-    {
-      register int key = kconf_id_hash (str, len);
-
-      if (key <= MAX_HASH_VALUE && key >= 0)
-        {
-          register int o = wordlist[key].name;
-          if (o >= 0)
-            {
-              register const char *s = o + kconf_id_strings;
-
-              if (*str == *s && !strncmp (str + 1, s + 1, len - 1) && s[len] == '\0')
-                return &wordlist[key];
-            }
-        }
-    }
-  return 0;
-}
-#line 50 "scripts/kconfig/zconf.gperf"
-
diff --git a/backport/kconf/zconf.l b/backport/kconf/zconf.l
new file mode 100644
index 00000000..045093d8
--- /dev/null
+++ b/backport/kconf/zconf.l
@@ -0,0 +1,372 @@
+%option nostdinit noyywrap never-interactive full ecs
+%option 8bit nodefault yylineno
+%option noinput
+%x COMMAND HELP STRING PARAM
+%{
+/*
+ * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
+ * Released under the terms of the GNU GPL v2.0.
+ */
+
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "lkc.h"
+
+#define START_STRSIZE	16
+
+static struct {
+	struct file *file;
+	int lineno;
+} current_pos;
+
+static char *text;
+static int text_size, text_asize;
+
+struct buffer {
+	struct buffer *parent;
+	YY_BUFFER_STATE state;
+};
+
+struct buffer *current_buf;
+
+static int last_ts, first_ts;
+
+static void zconf_endhelp(void);
+static void zconf_endfile(void);
+
+static void new_string(void)
+{
+	text = xmalloc(START_STRSIZE);
+	text_asize = START_STRSIZE;
+	text_size = 0;
+	*text = 0;
+}
+
+static void append_string(const char *str, int size)
+{
+	int new_size = text_size + size + 1;
+	if (new_size > text_asize) {
+		new_size += START_STRSIZE - 1;
+		new_size &= -START_STRSIZE;
+		text = xrealloc(text, new_size);
+		text_asize = new_size;
+	}
+	memcpy(text + text_size, str, size);
+	text_size += size;
+	text[text_size] = 0;
+}
+
+static void alloc_string(const char *str, int size)
+{
+	text = xmalloc(size + 1);
+	memcpy(text, str, size);
+	text[size] = 0;
+}
+
+static void warn_ignored_character(char chr)
+{
+	fprintf(stderr,
+	        "%s:%d:warning: ignoring unsupported character '%c'\n",
+	        zconf_curname(), zconf_lineno(), chr);
+}
+%}
+
+n	[A-Za-z0-9_-]
+
+%%
+	int str = 0;
+	int ts, i;
+
+[ \t]*#.*\n	|
+[ \t]*\n	{
+	return T_EOL;
+}
+[ \t]*#.*
+
+
+[ \t]+	{
+	BEGIN(COMMAND);
+}
+
+.	{
+	unput(yytext[0]);
+	BEGIN(COMMAND);
+}
+
+
+<COMMAND>{
+	{n}+	{
+		const struct kconf_id *id = kconf_id_lookup(yytext, yyleng);
+		BEGIN(PARAM);
+		current_pos.file = current_file;
+		current_pos.lineno = yylineno;
+		if (id && id->flags & TF_COMMAND) {
+			yylval.id = id;
+			return id->token;
+		}
+		alloc_string(yytext, yyleng);
+		yylval.string = text;
+		return T_WORD;
+	}
+	.	warn_ignored_character(*yytext);
+	\n	{
+		BEGIN(INITIAL);
+		return T_EOL;
+	}
+}
+
+<PARAM>{
+	"&&"	return T_AND;
+	"||"	return T_OR;
+	"("	return T_OPEN_PAREN;
+	")"	return T_CLOSE_PAREN;
+	"!"	return T_NOT;
+	"="	return T_EQUAL;
+	"!="	return T_UNEQUAL;
+	"<="	return T_LESS_EQUAL;
+	">="	return T_GREATER_EQUAL;
+	"<"	return T_LESS;
+	">"	return T_GREATER;
+	\"|\'	{
+		str = yytext[0];
+		new_string();
+		BEGIN(STRING);
+	}
+	\n	BEGIN(INITIAL); return T_EOL;
+	({n}|[/.])+	{
+		const struct kconf_id *id = kconf_id_lookup(yytext, yyleng);
+		if (id && id->flags & TF_PARAM) {
+			yylval.id = id;
+			return id->token;
+		}
+		alloc_string(yytext, yyleng);
+		yylval.string = text;
+		return T_WORD;
+	}
+	#.*	/* comment */
+	\\\n	;
+	[[:blank:]]+
+	.	warn_ignored_character(*yytext);
+	<<EOF>> {
+		BEGIN(INITIAL);
+	}
+}
+
+<STRING>{
+	[^'"\\\n]+/\n	{
+		append_string(yytext, yyleng);
+		yylval.string = text;
+		return T_WORD_QUOTE;
+	}
+	[^'"\\\n]+	{
+		append_string(yytext, yyleng);
+	}
+	\\.?/\n	{
+		append_string(yytext + 1, yyleng - 1);
+		yylval.string = text;
+		return T_WORD_QUOTE;
+	}
+	\\.?	{
+		append_string(yytext + 1, yyleng - 1);
+	}
+	\'|\"	{
+		if (str == yytext[0]) {
+			BEGIN(PARAM);
+			yylval.string = text;
+			return T_WORD_QUOTE;
+		} else
+			append_string(yytext, 1);
+	}
+	\n	{
+		fprintf(stderr,
+			"%s:%d:warning: multi-line strings not supported\n",
+			zconf_curname(), zconf_lineno());
+		BEGIN(INITIAL);
+		return T_EOL;
+	}
+	<<EOF>>	{
+		BEGIN(INITIAL);
+	}
+}
+
+<HELP>{
+	[ \t]+	{
+		ts = 0;
+		for (i = 0; i < yyleng; i++) {
+			if (yytext[i] == '\t')
+				ts = (ts & ~7) + 8;
+			else
+				ts++;
+		}
+		last_ts = ts;
+		if (first_ts) {
+			if (ts < first_ts) {
+				zconf_endhelp();
+				return T_HELPTEXT;
+			}
+			ts -= first_ts;
+			while (ts > 8) {
+				append_string("        ", 8);
+				ts -= 8;
+			}
+			append_string("        ", ts);
+		}
+	}
+	[ \t]*\n/[^ \t\n] {
+		zconf_endhelp();
+		return T_HELPTEXT;
+	}
+	[ \t]*\n	{
+		append_string("\n", 1);
+	}
+	[^ \t\n].* {
+		while (yyleng) {
+			if ((yytext[yyleng-1] != ' ') && (yytext[yyleng-1] != '\t'))
+				break;
+			yyleng--;
+		}
+		append_string(yytext, yyleng);
+		if (!first_ts)
+			first_ts = last_ts;
+	}
+	<<EOF>>	{
+		zconf_endhelp();
+		return T_HELPTEXT;
+	}
+}
+
+<<EOF>>	{
+	if (current_file) {
+		zconf_endfile();
+		return T_EOL;
+	}
+	fclose(yyin);
+	yyterminate();
+}
+
+%%
+void zconf_starthelp(void)
+{
+	new_string();
+	last_ts = first_ts = 0;
+	BEGIN(HELP);
+}
+
+static void zconf_endhelp(void)
+{
+	yylval.string = text;
+	BEGIN(INITIAL);
+}
+
+
+/*
+ * Try to open specified file with following names:
+ * ./name
+ * $(srctree)/name
+ * The latter is used when srctree is separate from objtree
+ * when compiling the kernel.
+ * Return NULL if file is not found.
+ */
+FILE *zconf_fopen(const char *name)
+{
+	char *env, fullname[PATH_MAX+1];
+	FILE *f;
+
+	f = fopen(name, "r");
+	if (!f && name != NULL && name[0] != '/') {
+		env = getenv(SRCTREE);
+		if (env) {
+			sprintf(fullname, "%s/%s", env, name);
+			f = fopen(fullname, "r");
+		}
+	}
+	return f;
+}
+
+void zconf_initscan(const char *name)
+{
+	yyin = zconf_fopen(name);
+	if (!yyin) {
+		fprintf(stderr, "can't find file %s\n", name);
+		exit(1);
+	}
+
+	current_buf = xmalloc(sizeof(*current_buf));
+	memset(current_buf, 0, sizeof(*current_buf));
+
+	current_file = file_lookup(name);
+	yylineno = 1;
+}
+
+void zconf_nextfile(const char *name)
+{
+	struct file *iter;
+	struct file *file = file_lookup(name);
+	struct buffer *buf = xmalloc(sizeof(*buf));
+	memset(buf, 0, sizeof(*buf));
+
+	current_buf->state = YY_CURRENT_BUFFER;
+	yyin = zconf_fopen(file->name);
+	if (!yyin) {
+		fprintf(stderr, "%s:%d: can't open file \"%s\"\n",
+			zconf_curname(), zconf_lineno(), file->name);
+		exit(1);
+	}
+	yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
+	buf->parent = current_buf;
+	current_buf = buf;
+
+	current_file->lineno = yylineno;
+	file->parent = current_file;
+
+	for (iter = current_file; iter; iter = iter->parent) {
+		if (!strcmp(iter->name, file->name)) {
+			fprintf(stderr,
+				"Recursive inclusion detected.\n"
+				"Inclusion path:\n"
+				"  current file : %s\n", file->name);
+			iter = file;
+			do {
+				iter = iter->parent;
+				fprintf(stderr, "  included from: %s:%d\n",
+					iter->name, iter->lineno - 1);
+			} while (strcmp(iter->name, file->name));
+			exit(1);
+		}
+	}
+
+	yylineno = 1;
+	current_file = file;
+}
+
+static void zconf_endfile(void)
+{
+	struct buffer *parent;
+
+	current_file = current_file->parent;
+	if (current_file)
+		yylineno = current_file->lineno;
+
+	parent = current_buf->parent;
+	if (parent) {
+		fclose(yyin);
+		yy_delete_buffer(YY_CURRENT_BUFFER);
+		yy_switch_to_buffer(parent->state);
+	}
+	free(current_buf);
+	current_buf = parent;
+}
+
+int zconf_lineno(void)
+{
+	return current_pos.lineno;
+}
+
+const char *zconf_curname(void)
+{
+	return current_pos.file ? current_pos.file->name : "<none>";
+}
diff --git a/backport/kconf/zconf.lex.c b/backport/kconf/zconf.lex.c
deleted file mode 100644
index 37fdf612..00000000
--- a/backport/kconf/zconf.lex.c
+++ /dev/null
@@ -1,2473 +0,0 @@
-
-#line 3 "scripts/kconfig/zconf.lex.c_shipped"
-
-#define  YY_INT_ALIGNED short int
-
-/* A lexical scanner generated by flex */
-
-#define yy_create_buffer zconf_create_buffer
-#define yy_delete_buffer zconf_delete_buffer
-#define yy_flex_debug zconf_flex_debug
-#define yy_init_buffer zconf_init_buffer
-#define yy_flush_buffer zconf_flush_buffer
-#define yy_load_buffer_state zconf_load_buffer_state
-#define yy_switch_to_buffer zconf_switch_to_buffer
-#define yyin zconfin
-#define yyleng zconfleng
-#define yylex zconflex
-#define yylineno zconflineno
-#define yyout zconfout
-#define yyrestart zconfrestart
-#define yytext zconftext
-#define yywrap zconfwrap
-#define yyalloc zconfalloc
-#define yyrealloc zconfrealloc
-#define yyfree zconffree
-
-#define FLEX_SCANNER
-#define YY_FLEX_MAJOR_VERSION 2
-#define YY_FLEX_MINOR_VERSION 5
-#define YY_FLEX_SUBMINOR_VERSION 35
-#if YY_FLEX_SUBMINOR_VERSION > 0
-#define FLEX_BETA
-#endif
-
-/* First, we deal with  platform-specific or compiler-specific issues. */
-
-/* begin standard C headers. */
-#include <stdio.h>
-#include <string.h>
-#include <errno.h>
-#include <stdlib.h>
-
-/* end standard C headers. */
-
-/* flex integer type definitions */
-
-#ifndef FLEXINT_H
-#define FLEXINT_H
-
-/* C99 systems have <inttypes.h>. Non-C99 systems may or may not. */
-
-#if defined (__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
-
-/* C99 says to define __STDC_LIMIT_MACROS before including stdint.h,
- * if you want the limit (max/min) macros for int types. 
- */
-#ifndef __STDC_LIMIT_MACROS
-#define __STDC_LIMIT_MACROS 1
-#endif
-
-#include <inttypes.h>
-typedef int8_t flex_int8_t;
-typedef uint8_t flex_uint8_t;
-typedef int16_t flex_int16_t;
-typedef uint16_t flex_uint16_t;
-typedef int32_t flex_int32_t;
-typedef uint32_t flex_uint32_t;
-#else
-typedef signed char flex_int8_t;
-typedef short int flex_int16_t;
-typedef int flex_int32_t;
-typedef unsigned char flex_uint8_t; 
-typedef unsigned short int flex_uint16_t;
-typedef unsigned int flex_uint32_t;
-
-/* Limits of integral types. */
-#ifndef INT8_MIN
-#define INT8_MIN               (-128)
-#endif
-#ifndef INT16_MIN
-#define INT16_MIN              (-32767-1)
-#endif
-#ifndef INT32_MIN
-#define INT32_MIN              (-2147483647-1)
-#endif
-#ifndef INT8_MAX
-#define INT8_MAX               (127)
-#endif
-#ifndef INT16_MAX
-#define INT16_MAX              (32767)
-#endif
-#ifndef INT32_MAX
-#define INT32_MAX              (2147483647)
-#endif
-#ifndef UINT8_MAX
-#define UINT8_MAX              (255U)
-#endif
-#ifndef UINT16_MAX
-#define UINT16_MAX             (65535U)
-#endif
-#ifndef UINT32_MAX
-#define UINT32_MAX             (4294967295U)
-#endif
-
-#endif /* ! C99 */
-
-#endif /* ! FLEXINT_H */
-
-#ifdef __cplusplus
-
-/* The "const" storage-class-modifier is valid. */
-#define YY_USE_CONST
-
-#else	/* ! __cplusplus */
-
-/* C99 requires __STDC__ to be defined as 1. */
-#if defined (__STDC__)
-
-#define YY_USE_CONST
-
-#endif	/* defined (__STDC__) */
-#endif	/* ! __cplusplus */
-
-#ifdef YY_USE_CONST
-#define yyconst const
-#else
-#define yyconst
-#endif
-
-/* Returned upon end-of-file. */
-#define YY_NULL 0
-
-/* Promotes a possibly negative, possibly signed char to an unsigned
- * integer for use as an array index.  If the signed char is negative,
- * we want to instead treat it as an 8-bit unsigned char, hence the
- * double cast.
- */
-#define YY_SC_TO_UI(c) ((unsigned int) (unsigned char) c)
-
-/* Enter a start condition.  This macro really ought to take a parameter,
- * but we do it the disgusting crufty way forced on us by the ()-less
- * definition of BEGIN.
- */
-#define BEGIN (yy_start) = 1 + 2 *
-
-/* Translate the current start state into a value that can be later handed
- * to BEGIN to return to the state.  The YYSTATE alias is for lex
- * compatibility.
- */
-#define YY_START (((yy_start) - 1) / 2)
-#define YYSTATE YY_START
-
-/* Action number for EOF rule of a given start state. */
-#define YY_STATE_EOF(state) (YY_END_OF_BUFFER + state + 1)
-
-/* Special action meaning "start processing a new file". */
-#define YY_NEW_FILE zconfrestart(zconfin  )
-
-#define YY_END_OF_BUFFER_CHAR 0
-
-/* Size of default input buffer. */
-#ifndef YY_BUF_SIZE
-#ifdef __ia64__
-/* On IA-64, the buffer size is 16k, not 8k.
- * Moreover, YY_BUF_SIZE is 2*YY_READ_BUF_SIZE in the general case.
- * Ditto for the __ia64__ case accordingly.
- */
-#define YY_BUF_SIZE 32768
-#else
-#define YY_BUF_SIZE 16384
-#endif /* __ia64__ */
-#endif
-
-/* The state buf must be large enough to hold one state per character in the main buffer.
- */
-#define YY_STATE_BUF_SIZE   ((YY_BUF_SIZE + 2) * sizeof(yy_state_type))
-
-#ifndef YY_TYPEDEF_YY_BUFFER_STATE
-#define YY_TYPEDEF_YY_BUFFER_STATE
-typedef struct yy_buffer_state *YY_BUFFER_STATE;
-#endif
-
-extern int zconfleng;
-
-extern FILE *zconfin, *zconfout;
-
-#define EOB_ACT_CONTINUE_SCAN 0
-#define EOB_ACT_END_OF_FILE 1
-#define EOB_ACT_LAST_MATCH 2
-
-    #define YY_LESS_LINENO(n)
-    
-/* Return all but the first "n" matched characters back to the input stream. */
-#define yyless(n) \
-	do \
-		{ \
-		/* Undo effects of setting up zconftext. */ \
-        int yyless_macro_arg = (n); \
-        YY_LESS_LINENO(yyless_macro_arg);\
-		*yy_cp = (yy_hold_char); \
-		YY_RESTORE_YY_MORE_OFFSET \
-		(yy_c_buf_p) = yy_cp = yy_bp + yyless_macro_arg - YY_MORE_ADJ; \
-		YY_DO_BEFORE_ACTION; /* set up zconftext again */ \
-		} \
-	while ( 0 )
-
-#define unput(c) yyunput( c, (yytext_ptr)  )
-
-#ifndef YY_TYPEDEF_YY_SIZE_T
-#define YY_TYPEDEF_YY_SIZE_T
-typedef size_t yy_size_t;
-#endif
-
-#ifndef YY_STRUCT_YY_BUFFER_STATE
-#define YY_STRUCT_YY_BUFFER_STATE
-struct yy_buffer_state
-	{
-	FILE *yy_input_file;
-
-	char *yy_ch_buf;		/* input buffer */
-	char *yy_buf_pos;		/* current position in input buffer */
-
-	/* Size of input buffer in bytes, not including room for EOB
-	 * characters.
-	 */
-	yy_size_t yy_buf_size;
-
-	/* Number of characters read into yy_ch_buf, not including EOB
-	 * characters.
-	 */
-	int yy_n_chars;
-
-	/* Whether we "own" the buffer - i.e., we know we created it,
-	 * and can realloc() it to grow it, and should free() it to
-	 * delete it.
-	 */
-	int yy_is_our_buffer;
-
-	/* Whether this is an "interactive" input source; if so, and
-	 * if we're using stdio for input, then we want to use getc()
-	 * instead of fread(), to make sure we stop fetching input after
-	 * each newline.
-	 */
-	int yy_is_interactive;
-
-	/* Whether we're considered to be at the beginning of a line.
-	 * If so, '^' rules will be active on the next match, otherwise
-	 * not.
-	 */
-	int yy_at_bol;
-
-    int yy_bs_lineno; /**< The line count. */
-    int yy_bs_column; /**< The column count. */
-    
-	/* Whether to try to fill the input buffer when we reach the
-	 * end of it.
-	 */
-	int yy_fill_buffer;
-
-	int yy_buffer_status;
-
-#define YY_BUFFER_NEW 0
-#define YY_BUFFER_NORMAL 1
-	/* When an EOF's been seen but there's still some text to process
-	 * then we mark the buffer as YY_EOF_PENDING, to indicate that we
-	 * shouldn't try reading from the input source any more.  We might
-	 * still have a bunch of tokens to match, though, because of
-	 * possible backing-up.
-	 *
-	 * When we actually see the EOF, we change the status to "new"
-	 * (via zconfrestart()), so that the user can continue scanning by
-	 * just pointing zconfin at a new input file.
-	 */
-#define YY_BUFFER_EOF_PENDING 2
-
-	};
-#endif /* !YY_STRUCT_YY_BUFFER_STATE */
-
-/* Stack of input buffers. */
-static size_t yy_buffer_stack_top = 0; /**< index of top of stack. */
-static size_t yy_buffer_stack_max = 0; /**< capacity of stack. */
-static YY_BUFFER_STATE * yy_buffer_stack = 0; /**< Stack as an array. */
-
-/* We provide macros for accessing buffer states in case in the
- * future we want to put the buffer states in a more general
- * "scanner state".
- *
- * Returns the top of the stack, or NULL.
- */
-#define YY_CURRENT_BUFFER ( (yy_buffer_stack) \
-                          ? (yy_buffer_stack)[(yy_buffer_stack_top)] \
-                          : NULL)
-
-/* Same as previous macro, but useful when we know that the buffer stack is not
- * NULL or when we need an lvalue. For internal use only.
- */
-#define YY_CURRENT_BUFFER_LVALUE (yy_buffer_stack)[(yy_buffer_stack_top)]
-
-/* yy_hold_char holds the character lost when zconftext is formed. */
-static char yy_hold_char;
-static int yy_n_chars;		/* number of characters read into yy_ch_buf */
-int zconfleng;
-
-/* Points to current character in buffer. */
-static char *yy_c_buf_p = (char *) 0;
-static int yy_init = 0;		/* whether we need to initialize */
-static int yy_start = 0;	/* start state number */
-
-/* Flag which is used to allow zconfwrap()'s to do buffer switches
- * instead of setting up a fresh zconfin.  A bit of a hack ...
- */
-static int yy_did_buffer_switch_on_eof;
-
-void zconfrestart (FILE *input_file  );
-void zconf_switch_to_buffer (YY_BUFFER_STATE new_buffer  );
-YY_BUFFER_STATE zconf_create_buffer (FILE *file,int size  );
-void zconf_delete_buffer (YY_BUFFER_STATE b  );
-void zconf_flush_buffer (YY_BUFFER_STATE b  );
-void zconfpush_buffer_state (YY_BUFFER_STATE new_buffer  );
-void zconfpop_buffer_state (void );
-
-static void zconfensure_buffer_stack (void );
-static void zconf_load_buffer_state (void );
-static void zconf_init_buffer (YY_BUFFER_STATE b,FILE *file  );
-
-#define YY_FLUSH_BUFFER zconf_flush_buffer(YY_CURRENT_BUFFER )
-
-YY_BUFFER_STATE zconf_scan_buffer (char *base,yy_size_t size  );
-YY_BUFFER_STATE zconf_scan_string (yyconst char *yy_str  );
-YY_BUFFER_STATE zconf_scan_bytes (yyconst char *bytes,int len  );
-
-void *zconfalloc (yy_size_t  );
-void *zconfrealloc (void *,yy_size_t  );
-void zconffree (void *  );
-
-#define yy_new_buffer zconf_create_buffer
-
-#define yy_set_interactive(is_interactive) \
-	{ \
-	if ( ! YY_CURRENT_BUFFER ){ \
-        zconfensure_buffer_stack (); \
-		YY_CURRENT_BUFFER_LVALUE =    \
-            zconf_create_buffer(zconfin,YY_BUF_SIZE ); \
-	} \
-	YY_CURRENT_BUFFER_LVALUE->yy_is_interactive = is_interactive; \
-	}
-
-#define yy_set_bol(at_bol) \
-	{ \
-	if ( ! YY_CURRENT_BUFFER ){\
-        zconfensure_buffer_stack (); \
-		YY_CURRENT_BUFFER_LVALUE =    \
-            zconf_create_buffer(zconfin,YY_BUF_SIZE ); \
-	} \
-	YY_CURRENT_BUFFER_LVALUE->yy_at_bol = at_bol; \
-	}
-
-#define YY_AT_BOL() (YY_CURRENT_BUFFER_LVALUE->yy_at_bol)
-
-/* Begin user sect3 */
-
-#define zconfwrap(n) 1
-#define YY_SKIP_YYWRAP
-
-typedef unsigned char YY_CHAR;
-
-FILE *zconfin = (FILE *) 0, *zconfout = (FILE *) 0;
-
-typedef int yy_state_type;
-
-extern int zconflineno;
-
-int zconflineno = 1;
-
-extern char *zconftext;
-#define yytext_ptr zconftext
-static yyconst flex_int16_t yy_nxt[][18] =
-    {
-    {
-        0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
-        0,    0,    0,    0,    0,    0,    0,    0
-    },
-
-    {
-       11,   12,   13,   14,   12,   12,   15,   12,   12,   12,
-       12,   12,   12,   12,   12,   12,   12,   12
-    },
-
-    {
-       11,   12,   13,   14,   12,   12,   15,   12,   12,   12,
-       12,   12,   12,   12,   12,   12,   12,   12
-    },
-
-    {
-       11,   16,   16,   17,   16,   16,   16,   16,   16,   16,
-       16,   18,   16,   16,   16,   16,   16,   16
-    },
-
-    {
-       11,   16,   16,   17,   16,   16,   16,   16,   16,   16,
-       16,   18,   16,   16,   16,   16,   16,   16
-
-    },
-
-    {
-       11,   19,   20,   21,   19,   19,   19,   19,   19,   19,
-       19,   19,   19,   19,   19,   19,   19,   19
-    },
-
-    {
-       11,   19,   20,   21,   19,   19,   19,   19,   19,   19,
-       19,   19,   19,   19,   19,   19,   19,   19
-    },
-
-    {
-       11,   22,   22,   23,   22,   24,   22,   22,   24,   22,
-       22,   22,   22,   22,   22,   22,   25,   22
-    },
-
-    {
-       11,   22,   22,   23,   22,   24,   22,   22,   24,   22,
-       22,   22,   22,   22,   22,   22,   25,   22
-    },
-
-    {
-       11,   26,   27,   28,   29,   30,   31,   32,   30,   33,
-       34,   35,   35,   36,   37,   38,   39,   40
-
-    },
-
-    {
-       11,   26,   27,   28,   29,   30,   31,   32,   30,   33,
-       34,   35,   35,   36,   37,   38,   39,   40
-    },
-
-    {
-      -11,  -11,  -11,  -11,  -11,  -11,  -11,  -11,  -11,  -11,
-      -11,  -11,  -11,  -11,  -11,  -11,  -11,  -11
-    },
-
-    {
-       11,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
-      -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12
-    },
-
-    {
-       11,  -13,   41,   42,  -13,  -13,   43,  -13,  -13,  -13,
-      -13,  -13,  -13,  -13,  -13,  -13,  -13,  -13
-    },
-
-    {
-       11,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
-      -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14
-
-    },
-
-    {
-       11,   44,   44,   45,   44,   44,   44,   44,   44,   44,
-       44,   44,   44,   44,   44,   44,   44,   44
-    },
-
-    {
-       11,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
-      -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16
-    },
-
-    {
-       11,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
-      -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17
-    },
-
-    {
-       11,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
-      -18,   46,  -18,  -18,  -18,  -18,  -18,  -18
-    },
-
-    {
-       11,   47,   47,  -19,   47,   47,   47,   47,   47,   47,
-       47,   47,   47,   47,   47,   47,   47,   47
-
-    },
-
-    {
-       11,  -20,   48,   49,  -20,  -20,  -20,  -20,  -20,  -20,
-      -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20
-    },
-
-    {
-       11,   50,  -21,  -21,   50,   50,   50,   50,   50,   50,
-       50,   50,   50,   50,   50,   50,   50,   50
-    },
-
-    {
-       11,   51,   51,   52,   51,  -22,   51,   51,  -22,   51,
-       51,   51,   51,   51,   51,   51,  -22,   51
-    },
-
-    {
-       11,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
-      -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23
-    },
-
-    {
-       11,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
-      -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24
-
-    },
-
-    {
-       11,   53,   53,   54,   53,   53,   53,   53,   53,   53,
-       53,   53,   53,   53,   53,   53,   53,   53
-    },
-
-    {
-       11,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
-      -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26
-    },
-
-    {
-       11,  -27,   55,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
-      -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27
-    },
-
-    {
-       11,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
-      -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28
-    },
-
-    {
-       11,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
-      -29,  -29,  -29,  -29,   56,  -29,  -29,  -29
-
-    },
-
-    {
-       11,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,
-      -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30
-    },
-
-    {
-       11,   57,   57,  -31,   57,   57,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57,   57,   57
-    },
-
-    {
-       11,  -32,  -32,  -32,  -32,  -32,  -32,   58,  -32,  -32,
-      -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32
-    },
-
-    {
-       11,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,
-      -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33
-    },
-
-    {
-       11,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,
-      -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34
-
-    },
-
-    {
-       11,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
-      -35,   59,   59,  -35,  -35,  -35,  -35,  -35
-    },
-
-    {
-       11,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,
-      -36,  -36,  -36,  -36,   60,  -36,  -36,  -36
-    },
-
-    {
-       11,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,
-      -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37
-    },
-
-    {
-       11,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,
-      -38,  -38,  -38,  -38,   61,  -38,  -38,  -38
-    },
-
-    {
-       11,  -39,  -39,   62,  -39,  -39,  -39,  -39,  -39,  -39,
-      -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39
-
-    },
-
-    {
-       11,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,
-      -40,  -40,  -40,  -40,  -40,  -40,  -40,   63
-    },
-
-    {
-       11,  -41,   41,   42,  -41,  -41,   43,  -41,  -41,  -41,
-      -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41
-    },
-
-    {
-       11,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,
-      -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42
-    },
-
-    {
-       11,   44,   44,   45,   44,   44,   44,   44,   44,   44,
-       44,   44,   44,   44,   44,   44,   44,   44
-    },
-
-    {
-       11,   44,   44,   45,   44,   44,   44,   44,   44,   44,
-       44,   44,   44,   44,   44,   44,   44,   44
-
-    },
-
-    {
-       11,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,
-      -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45
-    },
-
-    {
-       11,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,
-      -46,   46,  -46,  -46,  -46,  -46,  -46,  -46
-    },
-
-    {
-       11,   47,   47,  -47,   47,   47,   47,   47,   47,   47,
-       47,   47,   47,   47,   47,   47,   47,   47
-    },
-
-    {
-       11,  -48,   48,   49,  -48,  -48,  -48,  -48,  -48,  -48,
-      -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48
-    },
-
-    {
-       11,   50,  -49,  -49,   50,   50,   50,   50,   50,   50,
-       50,   50,   50,   50,   50,   50,   50,   50
-
-    },
-
-    {
-       11,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
-      -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50
-    },
-
-    {
-       11,   51,   51,   52,   51,  -51,   51,   51,  -51,   51,
-       51,   51,   51,   51,   51,   51,  -51,   51
-    },
-
-    {
-       11,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
-      -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52
-    },
-
-    {
-       11,  -53,  -53,   54,  -53,  -53,  -53,  -53,  -53,  -53,
-      -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53
-    },
-
-    {
-       11,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
-      -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54
-
-    },
-
-    {
-       11,  -55,   55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
-      -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55
-    },
-
-    {
-       11,  -56,  -56,  -56,  -56,  -56,  -56,  -56,  -56,  -56,
-      -56,  -56,  -56,  -56,  -56,  -56,  -56,  -56
-    },
-
-    {
-       11,   57,   57,  -57,   57,   57,   57,   57,   57,   57,
-       57,   57,   57,   57,   57,   57,   57,   57
-    },
-
-    {
-       11,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
-      -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58
-    },
-
-    {
-       11,  -59,  -59,  -59,  -59,  -59,  -59,  -59,  -59,  -59,
-      -59,   59,   59,  -59,  -59,  -59,  -59,  -59
-
-    },
-
-    {
-       11,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
-      -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60
-    },
-
-    {
-       11,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
-      -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61
-    },
-
-    {
-       11,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
-      -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62
-    },
-
-    {
-       11,  -63,  -63,  -63,  -63,  -63,  -63,  -63,  -63,  -63,
-      -63,  -63,  -63,  -63,  -63,  -63,  -63,  -63
-    },
-
-    } ;
-
-static yy_state_type yy_get_previous_state (void );
-static yy_state_type yy_try_NUL_trans (yy_state_type current_state  );
-static int yy_get_next_buffer (void );
-static void yy_fatal_error (yyconst char msg[]  );
-
-/* Done after the current pattern has been matched and before the
- * corresponding action - sets up zconftext.
- */
-#define YY_DO_BEFORE_ACTION \
-	(yytext_ptr) = yy_bp; \
-	zconfleng = (size_t) (yy_cp - yy_bp); \
-	(yy_hold_char) = *yy_cp; \
-	*yy_cp = '\0'; \
-	(yy_c_buf_p) = yy_cp;
-
-#define YY_NUM_RULES 37
-#define YY_END_OF_BUFFER 38
-/* This struct is not used in this scanner,
-   but its presence is necessary. */
-struct yy_trans_info
-	{
-	flex_int32_t yy_verify;
-	flex_int32_t yy_nxt;
-	};
-static yyconst flex_int16_t yy_accept[64] =
-    {   0,
-        0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
-       38,    5,    4,    2,    3,    7,    8,    6,   36,   33,
-       35,   28,   32,   31,   30,   26,   25,   21,   13,   20,
-       23,   26,   11,   12,   22,   18,   14,   19,   26,   26,
-        4,    2,    3,    3,    1,    6,   36,   33,   35,   34,
-       28,   27,   30,   29,   25,   15,   23,    9,   22,   16,
-       17,   24,   10
-    } ;
-
-static yyconst flex_int32_t yy_ec[256] =
-    {   0,
-        1,    1,    1,    1,    1,    1,    1,    1,    2,    3,
-        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
-        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
-        1,    2,    4,    5,    6,    1,    1,    7,    8,    9,
-       10,    1,    1,    1,   11,   12,   12,   11,   11,   11,
-       11,   11,   11,   11,   11,   11,   11,    1,    1,   13,
-       14,   15,    1,    1,   11,   11,   11,   11,   11,   11,
-       11,   11,   11,   11,   11,   11,   11,   11,   11,   11,
-       11,   11,   11,   11,   11,   11,   11,   11,   11,   11,
-        1,   16,    1,    1,   11,    1,   11,   11,   11,   11,
-
-       11,   11,   11,   11,   11,   11,   11,   11,   11,   11,
-       11,   11,   11,   11,   11,   11,   11,   11,   11,   11,
-       11,   11,    1,   17,    1,    1,    1,    1,    1,    1,
-        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
-        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
-        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
-        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
-        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
-        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
-        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
-
-        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
-        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
-        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
-        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
-        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
-        1,    1,    1,    1,    1
-    } ;
-
-extern int zconf_flex_debug;
-int zconf_flex_debug = 0;
-
-/* The intent behind this definition is that it'll catch
- * any uses of REJECT which flex missed.
- */
-#define REJECT reject_used_but_not_detected
-#define yymore() yymore_used_but_not_detected
-#define YY_MORE_ADJ 0
-#define YY_RESTORE_YY_MORE_OFFSET
-char *zconftext;
-#define YY_NO_INPUT 1
-
-/*
- * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
- * Released under the terms of the GNU GPL v2.0.
- */
-
-#include <limits.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-
-#include "lkc.h"
-
-#define START_STRSIZE	16
-
-static struct {
-	struct file *file;
-	int lineno;
-} current_pos;
-
-static char *text;
-static int text_size, text_asize;
-
-struct buffer {
-	struct buffer *parent;
-	YY_BUFFER_STATE state;
-};
-
-struct buffer *current_buf;
-
-static int last_ts, first_ts;
-
-static void zconf_endhelp(void);
-static void zconf_endfile(void);
-
-static void new_string(void)
-{
-	text = xmalloc(START_STRSIZE);
-	text_asize = START_STRSIZE;
-	text_size = 0;
-	*text = 0;
-}
-
-static void append_string(const char *str, int size)
-{
-	int new_size = text_size + size + 1;
-	if (new_size > text_asize) {
-		new_size += START_STRSIZE - 1;
-		new_size &= -START_STRSIZE;
-		text = realloc(text, new_size);
-		text_asize = new_size;
-	}
-	memcpy(text + text_size, str, size);
-	text_size += size;
-	text[text_size] = 0;
-}
-
-static void alloc_string(const char *str, int size)
-{
-	text = xmalloc(size + 1);
-	memcpy(text, str, size);
-	text[size] = 0;
-}
-
-static void warn_ignored_character(char chr)
-{
-	fprintf(stderr,
-	        "%s:%d:warning: ignoring unsupported character '%c'\n",
-	        zconf_curname(), zconf_lineno(), chr);
-}
-
-#define INITIAL 0
-#define COMMAND 1
-#define HELP 2
-#define STRING 3
-#define PARAM 4
-
-#ifndef YY_NO_UNISTD_H
-/* Special case for "unistd.h", since it is non-ANSI. We include it way
- * down here because we want the user's section 1 to have been scanned first.
- * The user has a chance to override it with an option.
- */
-#include <unistd.h>
-#endif
-
-#ifndef YY_EXTRA_TYPE
-#define YY_EXTRA_TYPE void *
-#endif
-
-static int yy_init_globals (void );
-
-/* Accessor methods to globals.
-   These are made visible to non-reentrant scanners for convenience. */
-
-int zconflex_destroy (void );
-
-int zconfget_debug (void );
-
-void zconfset_debug (int debug_flag  );
-
-YY_EXTRA_TYPE zconfget_extra (void );
-
-void zconfset_extra (YY_EXTRA_TYPE user_defined  );
-
-FILE *zconfget_in (void );
-
-void zconfset_in  (FILE * in_str  );
-
-FILE *zconfget_out (void );
-
-void zconfset_out  (FILE * out_str  );
-
-int zconfget_leng (void );
-
-char *zconfget_text (void );
-
-int zconfget_lineno (void );
-
-void zconfset_lineno (int line_number  );
-
-/* Macros after this point can all be overridden by user definitions in
- * section 1.
- */
-
-#ifndef YY_SKIP_YYWRAP
-#ifdef __cplusplus
-extern "C" int zconfwrap (void );
-#else
-extern int zconfwrap (void );
-#endif
-#endif
-
-    static void yyunput (int c,char *buf_ptr  );
-    
-#ifndef yytext_ptr
-static void yy_flex_strncpy (char *,yyconst char *,int );
-#endif
-
-#ifdef YY_NEED_STRLEN
-static int yy_flex_strlen (yyconst char * );
-#endif
-
-#ifndef YY_NO_INPUT
-
-#ifdef __cplusplus
-static int yyinput (void );
-#else
-static int input (void );
-#endif
-
-#endif
-
-/* Amount of stuff to slurp up with each read. */
-#ifndef YY_READ_BUF_SIZE
-#ifdef __ia64__
-/* On IA-64, the buffer size is 16k, not 8k */
-#define YY_READ_BUF_SIZE 16384
-#else
-#define YY_READ_BUF_SIZE 8192
-#endif /* __ia64__ */
-#endif
-
-/* Copy whatever the last rule matched to the standard output. */
-#ifndef ECHO
-/* This used to be an fputs(), but since the string might contain NUL's,
- * we now use fwrite().
- */
-#define ECHO do { if (fwrite( zconftext, zconfleng, 1, zconfout )) {} } while (0)
-#endif
-
-/* Gets input and stuffs it into "buf".  number of characters read, or YY_NULL,
- * is returned in "result".
- */
-#ifndef YY_INPUT
-#define YY_INPUT(buf,result,max_size) \
-	errno=0; \
-	while ( (result = read( fileno(zconfin), (char *) buf, max_size )) < 0 ) \
-	{ \
-		if( errno != EINTR) \
-		{ \
-			YY_FATAL_ERROR( "input in flex scanner failed" ); \
-			break; \
-		} \
-		errno=0; \
-		clearerr(zconfin); \
-	}\
-\
-
-#endif
-
-/* No semi-colon after return; correct usage is to write "yyterminate();" -
- * we don't want an extra ';' after the "return" because that will cause
- * some compilers to complain about unreachable statements.
- */
-#ifndef yyterminate
-#define yyterminate() return YY_NULL
-#endif
-
-/* Number of entries by which start-condition stack grows. */
-#ifndef YY_START_STACK_INCR
-#define YY_START_STACK_INCR 25
-#endif
-
-/* Report a fatal error. */
-#ifndef YY_FATAL_ERROR
-#define YY_FATAL_ERROR(msg) yy_fatal_error( msg )
-#endif
-
-/* end tables serialization structures and prototypes */
-
-/* Default declaration of generated scanner - a define so the user can
- * easily add parameters.
- */
-#ifndef YY_DECL
-#define YY_DECL_IS_OURS 1
-
-extern int zconflex (void);
-
-#define YY_DECL int zconflex (void)
-#endif /* !YY_DECL */
-
-/* Code executed at the beginning of each rule, after zconftext and zconfleng
- * have been set up.
- */
-#ifndef YY_USER_ACTION
-#define YY_USER_ACTION
-#endif
-
-/* Code executed at the end of each rule. */
-#ifndef YY_BREAK
-#define YY_BREAK break;
-#endif
-
-#define YY_RULE_SETUP \
-	YY_USER_ACTION
-
-/** The main scanner function which does all the work.
- */
-YY_DECL
-{
-	register yy_state_type yy_current_state;
-	register char *yy_cp, *yy_bp;
-	register int yy_act;
-    
-	int str = 0;
-	int ts, i;
-
-	if ( !(yy_init) )
-		{
-		(yy_init) = 1;
-
-#ifdef YY_USER_INIT
-		YY_USER_INIT;
-#endif
-
-		if ( ! (yy_start) )
-			(yy_start) = 1;	/* first start state */
-
-		if ( ! zconfin )
-			zconfin = stdin;
-
-		if ( ! zconfout )
-			zconfout = stdout;
-
-		if ( ! YY_CURRENT_BUFFER ) {
-			zconfensure_buffer_stack ();
-			YY_CURRENT_BUFFER_LVALUE =
-				zconf_create_buffer(zconfin,YY_BUF_SIZE );
-		}
-
-		zconf_load_buffer_state( );
-		}
-
-	while ( 1 )		/* loops until end-of-file is reached */
-		{
-		yy_cp = (yy_c_buf_p);
-
-		/* Support of zconftext. */
-		*yy_cp = (yy_hold_char);
-
-		/* yy_bp points to the position in yy_ch_buf of the start of
-		 * the current run.
-		 */
-		yy_bp = yy_cp;
-
-		yy_current_state = (yy_start);
-yy_match:
-		while ( (yy_current_state = yy_nxt[yy_current_state][ yy_ec[YY_SC_TO_UI(*yy_cp)]  ]) > 0 )
-			++yy_cp;
-
-		yy_current_state = -yy_current_state;
-
-yy_find_action:
-		yy_act = yy_accept[yy_current_state];
-
-		YY_DO_BEFORE_ACTION;
-
-do_action:	/* This label is used only to access EOF actions. */
-
-		switch ( yy_act )
-	{ /* beginning of action switch */
-case 1:
-/* rule 1 can match eol */
-case 2:
-/* rule 2 can match eol */
-YY_RULE_SETUP
-{
-	current_file->lineno++;
-	return T_EOL;
-}
-	YY_BREAK
-case 3:
-YY_RULE_SETUP
-
-	YY_BREAK
-case 4:
-YY_RULE_SETUP
-{
-	BEGIN(COMMAND);
-}
-	YY_BREAK
-case 5:
-YY_RULE_SETUP
-{
-	unput(zconftext[0]);
-	BEGIN(COMMAND);
-}
-	YY_BREAK
-
-case 6:
-YY_RULE_SETUP
-{
-		const struct kconf_id *id = kconf_id_lookup(zconftext, zconfleng);
-		BEGIN(PARAM);
-		current_pos.file = current_file;
-		current_pos.lineno = current_file->lineno;
-		if (id && id->flags & TF_COMMAND) {
-			zconflval.id = id;
-			return id->token;
-		}
-		alloc_string(zconftext, zconfleng);
-		zconflval.string = text;
-		return T_WORD;
-	}
-	YY_BREAK
-case 7:
-YY_RULE_SETUP
-warn_ignored_character(*zconftext);
-	YY_BREAK
-case 8:
-/* rule 8 can match eol */
-YY_RULE_SETUP
-{
-		BEGIN(INITIAL);
-		current_file->lineno++;
-		return T_EOL;
-	}
-	YY_BREAK
-
-case 9:
-YY_RULE_SETUP
-return T_AND;
-	YY_BREAK
-case 10:
-YY_RULE_SETUP
-return T_OR;
-	YY_BREAK
-case 11:
-YY_RULE_SETUP
-return T_OPEN_PAREN;
-	YY_BREAK
-case 12:
-YY_RULE_SETUP
-return T_CLOSE_PAREN;
-	YY_BREAK
-case 13:
-YY_RULE_SETUP
-return T_NOT;
-	YY_BREAK
-case 14:
-YY_RULE_SETUP
-return T_EQUAL;
-	YY_BREAK
-case 15:
-YY_RULE_SETUP
-return T_UNEQUAL;
-	YY_BREAK
-case 16:
-YY_RULE_SETUP
-return T_LESS_EQUAL;
-	YY_BREAK
-case 17:
-YY_RULE_SETUP
-return T_GREATER_EQUAL;
-	YY_BREAK
-case 18:
-YY_RULE_SETUP
-return T_LESS;
-	YY_BREAK
-case 19:
-YY_RULE_SETUP
-return T_GREATER;
-	YY_BREAK
-case 20:
-YY_RULE_SETUP
-{
-		str = zconftext[0];
-		new_string();
-		BEGIN(STRING);
-	}
-	YY_BREAK
-case 21:
-/* rule 21 can match eol */
-YY_RULE_SETUP
-BEGIN(INITIAL); current_file->lineno++; return T_EOL;
-	YY_BREAK
-case 22:
-YY_RULE_SETUP
-{
-		const struct kconf_id *id = kconf_id_lookup(zconftext, zconfleng);
-		if (id && id->flags & TF_PARAM) {
-			zconflval.id = id;
-			return id->token;
-		}
-		alloc_string(zconftext, zconfleng);
-		zconflval.string = text;
-		return T_WORD;
-	}
-	YY_BREAK
-case 23:
-YY_RULE_SETUP
-/* comment */
-	YY_BREAK
-case 24:
-/* rule 24 can match eol */
-YY_RULE_SETUP
-current_file->lineno++;
-	YY_BREAK
-case 25:
-YY_RULE_SETUP
-
-	YY_BREAK
-case 26:
-YY_RULE_SETUP
-warn_ignored_character(*zconftext);
-	YY_BREAK
-case YY_STATE_EOF(PARAM):
-{
-		BEGIN(INITIAL);
-	}
-	YY_BREAK
-
-case 27:
-/* rule 27 can match eol */
-*yy_cp = (yy_hold_char); /* undo effects of setting up zconftext */
-(yy_c_buf_p) = yy_cp -= 1;
-YY_DO_BEFORE_ACTION; /* set up zconftext again */
-YY_RULE_SETUP
-{
-		append_string(zconftext, zconfleng);
-		zconflval.string = text;
-		return T_WORD_QUOTE;
-	}
-	YY_BREAK
-case 28:
-YY_RULE_SETUP
-{
-		append_string(zconftext, zconfleng);
-	}
-	YY_BREAK
-case 29:
-/* rule 29 can match eol */
-*yy_cp = (yy_hold_char); /* undo effects of setting up zconftext */
-(yy_c_buf_p) = yy_cp -= 1;
-YY_DO_BEFORE_ACTION; /* set up zconftext again */
-YY_RULE_SETUP
-{
-		append_string(zconftext + 1, zconfleng - 1);
-		zconflval.string = text;
-		return T_WORD_QUOTE;
-	}
-	YY_BREAK
-case 30:
-YY_RULE_SETUP
-{
-		append_string(zconftext + 1, zconfleng - 1);
-	}
-	YY_BREAK
-case 31:
-YY_RULE_SETUP
-{
-		if (str == zconftext[0]) {
-			BEGIN(PARAM);
-			zconflval.string = text;
-			return T_WORD_QUOTE;
-		} else
-			append_string(zconftext, 1);
-	}
-	YY_BREAK
-case 32:
-/* rule 32 can match eol */
-YY_RULE_SETUP
-{
-		printf("%s:%d:warning: multi-line strings not supported\n", zconf_curname(), zconf_lineno());
-		current_file->lineno++;
-		BEGIN(INITIAL);
-		return T_EOL;
-	}
-	YY_BREAK
-case YY_STATE_EOF(STRING):
-{
-		BEGIN(INITIAL);
-	}
-	YY_BREAK
-
-case 33:
-YY_RULE_SETUP
-{
-		ts = 0;
-		for (i = 0; i < zconfleng; i++) {
-			if (zconftext[i] == '\t')
-				ts = (ts & ~7) + 8;
-			else
-				ts++;
-		}
-		last_ts = ts;
-		if (first_ts) {
-			if (ts < first_ts) {
-				zconf_endhelp();
-				return T_HELPTEXT;
-			}
-			ts -= first_ts;
-			while (ts > 8) {
-				append_string("        ", 8);
-				ts -= 8;
-			}
-			append_string("        ", ts);
-		}
-	}
-	YY_BREAK
-case 34:
-/* rule 34 can match eol */
-*yy_cp = (yy_hold_char); /* undo effects of setting up zconftext */
-(yy_c_buf_p) = yy_cp -= 1;
-YY_DO_BEFORE_ACTION; /* set up zconftext again */
-YY_RULE_SETUP
-{
-		current_file->lineno++;
-		zconf_endhelp();
-		return T_HELPTEXT;
-	}
-	YY_BREAK
-case 35:
-/* rule 35 can match eol */
-YY_RULE_SETUP
-{
-		current_file->lineno++;
-		append_string("\n", 1);
-	}
-	YY_BREAK
-case 36:
-YY_RULE_SETUP
-{
-		while (zconfleng) {
-			if ((zconftext[zconfleng-1] != ' ') && (zconftext[zconfleng-1] != '\t'))
-				break;
-			zconfleng--;
-		}
-		append_string(zconftext, zconfleng);
-		if (!first_ts)
-			first_ts = last_ts;
-	}
-	YY_BREAK
-case YY_STATE_EOF(HELP):
-{
-		zconf_endhelp();
-		return T_HELPTEXT;
-	}
-	YY_BREAK
-
-case YY_STATE_EOF(INITIAL):
-case YY_STATE_EOF(COMMAND):
-{
-	if (current_file) {
-		zconf_endfile();
-		return T_EOL;
-	}
-	fclose(zconfin);
-	yyterminate();
-}
-	YY_BREAK
-case 37:
-YY_RULE_SETUP
-YY_FATAL_ERROR( "flex scanner jammed" );
-	YY_BREAK
-
-	case YY_END_OF_BUFFER:
-		{
-		/* Amount of text matched not including the EOB char. */
-		int yy_amount_of_matched_text = (int) (yy_cp - (yytext_ptr)) - 1;
-
-		/* Undo the effects of YY_DO_BEFORE_ACTION. */
-		*yy_cp = (yy_hold_char);
-		YY_RESTORE_YY_MORE_OFFSET
-
-		if ( YY_CURRENT_BUFFER_LVALUE->yy_buffer_status == YY_BUFFER_NEW )
-			{
-			/* We're scanning a new file or input source.  It's
-			 * possible that this happened because the user
-			 * just pointed zconfin at a new source and called
-			 * zconflex().  If so, then we have to assure
-			 * consistency between YY_CURRENT_BUFFER and our
-			 * globals.  Here is the right place to do so, because
-			 * this is the first action (other than possibly a
-			 * back-up) that will match for the new input source.
-			 */
-			(yy_n_chars) = YY_CURRENT_BUFFER_LVALUE->yy_n_chars;
-			YY_CURRENT_BUFFER_LVALUE->yy_input_file = zconfin;
-			YY_CURRENT_BUFFER_LVALUE->yy_buffer_status = YY_BUFFER_NORMAL;
-			}
-
-		/* Note that here we test for yy_c_buf_p "<=" to the position
-		 * of the first EOB in the buffer, since yy_c_buf_p will
-		 * already have been incremented past the NUL character
-		 * (since all states make transitions on EOB to the
-		 * end-of-buffer state).  Contrast this with the test
-		 * in input().
-		 */
-		if ( (yy_c_buf_p) <= &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)] )
-			{ /* This was really a NUL. */
-			yy_state_type yy_next_state;
-
-			(yy_c_buf_p) = (yytext_ptr) + yy_amount_of_matched_text;
-
-			yy_current_state = yy_get_previous_state(  );
-
-			/* Okay, we're now positioned to make the NUL
-			 * transition.  We couldn't have
-			 * yy_get_previous_state() go ahead and do it
-			 * for us because it doesn't know how to deal
-			 * with the possibility of jamming (and we don't
-			 * want to build jamming into it because then it
-			 * will run more slowly).
-			 */
-
-			yy_next_state = yy_try_NUL_trans( yy_current_state );
-
-			yy_bp = (yytext_ptr) + YY_MORE_ADJ;
-
-			if ( yy_next_state )
-				{
-				/* Consume the NUL. */
-				yy_cp = ++(yy_c_buf_p);
-				yy_current_state = yy_next_state;
-				goto yy_match;
-				}
-
-			else
-				{
-				yy_cp = (yy_c_buf_p);
-				goto yy_find_action;
-				}
-			}
-
-		else switch ( yy_get_next_buffer(  ) )
-			{
-			case EOB_ACT_END_OF_FILE:
-				{
-				(yy_did_buffer_switch_on_eof) = 0;
-
-				if ( zconfwrap( ) )
-					{
-					/* Note: because we've taken care in
-					 * yy_get_next_buffer() to have set up
-					 * zconftext, we can now set up
-					 * yy_c_buf_p so that if some total
-					 * hoser (like flex itself) wants to
-					 * call the scanner after we return the
-					 * YY_NULL, it'll still work - another
-					 * YY_NULL will get returned.
-					 */
-					(yy_c_buf_p) = (yytext_ptr) + YY_MORE_ADJ;
-
-					yy_act = YY_STATE_EOF(YY_START);
-					goto do_action;
-					}
-
-				else
-					{
-					if ( ! (yy_did_buffer_switch_on_eof) )
-						YY_NEW_FILE;
-					}
-				break;
-				}
-
-			case EOB_ACT_CONTINUE_SCAN:
-				(yy_c_buf_p) =
-					(yytext_ptr) + yy_amount_of_matched_text;
-
-				yy_current_state = yy_get_previous_state(  );
-
-				yy_cp = (yy_c_buf_p);
-				yy_bp = (yytext_ptr) + YY_MORE_ADJ;
-				goto yy_match;
-
-			case EOB_ACT_LAST_MATCH:
-				(yy_c_buf_p) =
-				&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)];
-
-				yy_current_state = yy_get_previous_state(  );
-
-				yy_cp = (yy_c_buf_p);
-				yy_bp = (yytext_ptr) + YY_MORE_ADJ;
-				goto yy_find_action;
-			}
-		break;
-		}
-
-	default:
-		YY_FATAL_ERROR(
-			"fatal flex scanner internal error--no action found" );
-	} /* end of action switch */
-		} /* end of scanning one token */
-} /* end of zconflex */
-
-/* yy_get_next_buffer - try to read in a new buffer
- *
- * Returns a code representing an action:
- *	EOB_ACT_LAST_MATCH -
- *	EOB_ACT_CONTINUE_SCAN - continue scanning from current position
- *	EOB_ACT_END_OF_FILE - end of file
- */
-static int yy_get_next_buffer (void)
-{
-    	register char *dest = YY_CURRENT_BUFFER_LVALUE->yy_ch_buf;
-	register char *source = (yytext_ptr);
-	register int number_to_move, i;
-	int ret_val;
-
-	if ( (yy_c_buf_p) > &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars) + 1] )
-		YY_FATAL_ERROR(
-		"fatal flex scanner internal error--end of buffer missed" );
-
-	if ( YY_CURRENT_BUFFER_LVALUE->yy_fill_buffer == 0 )
-		{ /* Don't try to fill the buffer, so this is an EOF. */
-		if ( (yy_c_buf_p) - (yytext_ptr) - YY_MORE_ADJ == 1 )
-			{
-			/* We matched a single character, the EOB, so
-			 * treat this as a final EOF.
-			 */
-			return EOB_ACT_END_OF_FILE;
-			}
-
-		else
-			{
-			/* We matched some text prior to the EOB, first
-			 * process it.
-			 */
-			return EOB_ACT_LAST_MATCH;
-			}
-		}
-
-	/* Try to read more data. */
-
-	/* First move last chars to start of buffer. */
-	number_to_move = (int) ((yy_c_buf_p) - (yytext_ptr)) - 1;
-
-	for ( i = 0; i < number_to_move; ++i )
-		*(dest++) = *(source++);
-
-	if ( YY_CURRENT_BUFFER_LVALUE->yy_buffer_status == YY_BUFFER_EOF_PENDING )
-		/* don't do the read, it's not guaranteed to return an EOF,
-		 * just force an EOF
-		 */
-		YY_CURRENT_BUFFER_LVALUE->yy_n_chars = (yy_n_chars) = 0;
-
-	else
-		{
-			int num_to_read =
-			YY_CURRENT_BUFFER_LVALUE->yy_buf_size - number_to_move - 1;
-
-		while ( num_to_read <= 0 )
-			{ /* Not enough room in the buffer - grow it. */
-
-			/* just a shorter name for the current buffer */
-			YY_BUFFER_STATE b = YY_CURRENT_BUFFER;
-
-			int yy_c_buf_p_offset =
-				(int) ((yy_c_buf_p) - b->yy_ch_buf);
-
-			if ( b->yy_is_our_buffer )
-				{
-				int new_size = b->yy_buf_size * 2;
-
-				if ( new_size <= 0 )
-					b->yy_buf_size += b->yy_buf_size / 8;
-				else
-					b->yy_buf_size *= 2;
-
-				b->yy_ch_buf = (char *)
-					/* Include room in for 2 EOB chars. */
-					zconfrealloc((void *) b->yy_ch_buf,b->yy_buf_size + 2  );
-				}
-			else
-				/* Can't grow it, we don't own it. */
-				b->yy_ch_buf = 0;
-
-			if ( ! b->yy_ch_buf )
-				YY_FATAL_ERROR(
-				"fatal error - scanner input buffer overflow" );
-
-			(yy_c_buf_p) = &b->yy_ch_buf[yy_c_buf_p_offset];
-
-			num_to_read = YY_CURRENT_BUFFER_LVALUE->yy_buf_size -
-						number_to_move - 1;
-
-			}
-
-		if ( num_to_read > YY_READ_BUF_SIZE )
-			num_to_read = YY_READ_BUF_SIZE;
-
-		/* Read in more data. */
-		YY_INPUT( (&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move]),
-			(yy_n_chars), (size_t) num_to_read );
-
-		YY_CURRENT_BUFFER_LVALUE->yy_n_chars = (yy_n_chars);
-		}
-
-	if ( (yy_n_chars) == 0 )
-		{
-		if ( number_to_move == YY_MORE_ADJ )
-			{
-			ret_val = EOB_ACT_END_OF_FILE;
-			zconfrestart(zconfin  );
-			}
-
-		else
-			{
-			ret_val = EOB_ACT_LAST_MATCH;
-			YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =
-				YY_BUFFER_EOF_PENDING;
-			}
-		}
-
-	else
-		ret_val = EOB_ACT_CONTINUE_SCAN;
-
-	if ((yy_size_t) ((yy_n_chars) + number_to_move) > YY_CURRENT_BUFFER_LVALUE->yy_buf_size) {
-		/* Extend the array by 50%, plus the number we really need. */
-		yy_size_t new_size = (yy_n_chars) + number_to_move + ((yy_n_chars) >> 1);
-		YY_CURRENT_BUFFER_LVALUE->yy_ch_buf = (char *) zconfrealloc((void *) YY_CURRENT_BUFFER_LVALUE->yy_ch_buf,new_size  );
-		if ( ! YY_CURRENT_BUFFER_LVALUE->yy_ch_buf )
-			YY_FATAL_ERROR( "out of dynamic memory in yy_get_next_buffer()" );
-	}
-
-	(yy_n_chars) += number_to_move;
-	YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)] = YY_END_OF_BUFFER_CHAR;
-	YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars) + 1] = YY_END_OF_BUFFER_CHAR;
-
-	(yytext_ptr) = &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[0];
-
-	return ret_val;
-}
-
-/* yy_get_previous_state - get the state just before the EOB char was reached */
-
-    static yy_state_type yy_get_previous_state (void)
-{
-	register yy_state_type yy_current_state;
-	register char *yy_cp;
-    
-	yy_current_state = (yy_start);
-
-	for ( yy_cp = (yytext_ptr) + YY_MORE_ADJ; yy_cp < (yy_c_buf_p); ++yy_cp )
-		{
-		yy_current_state = yy_nxt[yy_current_state][(*yy_cp ? yy_ec[YY_SC_TO_UI(*yy_cp)] : 1)];
-		}
-
-	return yy_current_state;
-}
-
-/* yy_try_NUL_trans - try to make a transition on the NUL character
- *
- * synopsis
- *	next_state = yy_try_NUL_trans( current_state );
- */
-    static yy_state_type yy_try_NUL_trans  (yy_state_type yy_current_state )
-{
-	register int yy_is_jam;
-    
-	yy_current_state = yy_nxt[yy_current_state][1];
-	yy_is_jam = (yy_current_state <= 0);
-
-	return yy_is_jam ? 0 : yy_current_state;
-}
-
-    static void yyunput (int c, register char * yy_bp )
-{
-	register char *yy_cp;
-    
-    yy_cp = (yy_c_buf_p);
-
-	/* undo effects of setting up zconftext */
-	*yy_cp = (yy_hold_char);
-
-	if ( yy_cp < YY_CURRENT_BUFFER_LVALUE->yy_ch_buf + 2 )
-		{ /* need to shift things up to make room */
-		/* +2 for EOB chars. */
-		register int number_to_move = (yy_n_chars) + 2;
-		register char *dest = &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[
-					YY_CURRENT_BUFFER_LVALUE->yy_buf_size + 2];
-		register char *source =
-				&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move];
-
-		while ( source > YY_CURRENT_BUFFER_LVALUE->yy_ch_buf )
-			*--dest = *--source;
-
-		yy_cp += (int) (dest - source);
-		yy_bp += (int) (dest - source);
-		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =
-			(yy_n_chars) = YY_CURRENT_BUFFER_LVALUE->yy_buf_size;
-
-		if ( yy_cp < YY_CURRENT_BUFFER_LVALUE->yy_ch_buf + 2 )
-			YY_FATAL_ERROR( "flex scanner push-back overflow" );
-		}
-
-	*--yy_cp = (char) c;
-
-	(yytext_ptr) = yy_bp;
-	(yy_hold_char) = *yy_cp;
-	(yy_c_buf_p) = yy_cp;
-}
-
-#ifndef YY_NO_INPUT
-#ifdef __cplusplus
-    static int yyinput (void)
-#else
-    static int input  (void)
-#endif
-
-{
-	int c;
-    
-	*(yy_c_buf_p) = (yy_hold_char);
-
-	if ( *(yy_c_buf_p) == YY_END_OF_BUFFER_CHAR )
-		{
-		/* yy_c_buf_p now points to the character we want to return.
-		 * If this occurs *before* the EOB characters, then it's a
-		 * valid NUL; if not, then we've hit the end of the buffer.
-		 */
-		if ( (yy_c_buf_p) < &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)] )
-			/* This was really a NUL. */
-			*(yy_c_buf_p) = '\0';
-
-		else
-			{ /* need more input */
-			int offset = (yy_c_buf_p) - (yytext_ptr);
-			++(yy_c_buf_p);
-
-			switch ( yy_get_next_buffer(  ) )
-				{
-				case EOB_ACT_LAST_MATCH:
-					/* This happens because yy_g_n_b()
-					 * sees that we've accumulated a
-					 * token and flags that we need to
-					 * try matching the token before
-					 * proceeding.  But for input(),
-					 * there's no matching to consider.
-					 * So convert the EOB_ACT_LAST_MATCH
-					 * to EOB_ACT_END_OF_FILE.
-					 */
-
-					/* Reset buffer status. */
-					zconfrestart(zconfin );
-
-					/*FALLTHROUGH*/
-
-				case EOB_ACT_END_OF_FILE:
-					{
-					if ( zconfwrap( ) )
-						return EOF;
-
-					if ( ! (yy_did_buffer_switch_on_eof) )
-						YY_NEW_FILE;
-#ifdef __cplusplus
-					return yyinput();
-#else
-					return input();
-#endif
-					}
-
-				case EOB_ACT_CONTINUE_SCAN:
-					(yy_c_buf_p) = (yytext_ptr) + offset;
-					break;
-				}
-			}
-		}
-
-	c = *(unsigned char *) (yy_c_buf_p);	/* cast for 8-bit char's */
-	*(yy_c_buf_p) = '\0';	/* preserve zconftext */
-	(yy_hold_char) = *++(yy_c_buf_p);
-
-	return c;
-}
-#endif	/* ifndef YY_NO_INPUT */
-
-/** Immediately switch to a different input stream.
- * @param input_file A readable stream.
- * 
- * @note This function does not reset the start condition to @c INITIAL .
- */
-    void zconfrestart  (FILE * input_file )
-{
-    
-	if ( ! YY_CURRENT_BUFFER ){
-        zconfensure_buffer_stack ();
-		YY_CURRENT_BUFFER_LVALUE =
-            zconf_create_buffer(zconfin,YY_BUF_SIZE );
-	}
-
-	zconf_init_buffer(YY_CURRENT_BUFFER,input_file );
-	zconf_load_buffer_state( );
-}
-
-/** Switch to a different input buffer.
- * @param new_buffer The new input buffer.
- * 
- */
-    void zconf_switch_to_buffer  (YY_BUFFER_STATE  new_buffer )
-{
-    
-	/* TODO. We should be able to replace this entire function body
-	 * with
-	 *		zconfpop_buffer_state();
-	 *		zconfpush_buffer_state(new_buffer);
-     */
-	zconfensure_buffer_stack ();
-	if ( YY_CURRENT_BUFFER == new_buffer )
-		return;
-
-	if ( YY_CURRENT_BUFFER )
-		{
-		/* Flush out information for old buffer. */
-		*(yy_c_buf_p) = (yy_hold_char);
-		YY_CURRENT_BUFFER_LVALUE->yy_buf_pos = (yy_c_buf_p);
-		YY_CURRENT_BUFFER_LVALUE->yy_n_chars = (yy_n_chars);
-		}
-
-	YY_CURRENT_BUFFER_LVALUE = new_buffer;
-	zconf_load_buffer_state( );
-
-	/* We don't actually know whether we did this switch during
-	 * EOF (zconfwrap()) processing, but the only time this flag
-	 * is looked at is after zconfwrap() is called, so it's safe
-	 * to go ahead and always set it.
-	 */
-	(yy_did_buffer_switch_on_eof) = 1;
-}
-
-static void zconf_load_buffer_state  (void)
-{
-    	(yy_n_chars) = YY_CURRENT_BUFFER_LVALUE->yy_n_chars;
-	(yytext_ptr) = (yy_c_buf_p) = YY_CURRENT_BUFFER_LVALUE->yy_buf_pos;
-	zconfin = YY_CURRENT_BUFFER_LVALUE->yy_input_file;
-	(yy_hold_char) = *(yy_c_buf_p);
-}
-
-/** Allocate and initialize an input buffer state.
- * @param file A readable stream.
- * @param size The character buffer size in bytes. When in doubt, use @c YY_BUF_SIZE.
- * 
- * @return the allocated buffer state.
- */
-    YY_BUFFER_STATE zconf_create_buffer  (FILE * file, int  size )
-{
-	YY_BUFFER_STATE b;
-    
-	b = (YY_BUFFER_STATE) zconfalloc(sizeof( struct yy_buffer_state )  );
-	if ( ! b )
-		YY_FATAL_ERROR( "out of dynamic memory in zconf_create_buffer()" );
-
-	b->yy_buf_size = size;
-
-	/* yy_ch_buf has to be 2 characters longer than the size given because
-	 * we need to put in 2 end-of-buffer characters.
-	 */
-	b->yy_ch_buf = (char *) zconfalloc(b->yy_buf_size + 2  );
-	if ( ! b->yy_ch_buf )
-		YY_FATAL_ERROR( "out of dynamic memory in zconf_create_buffer()" );
-
-	b->yy_is_our_buffer = 1;
-
-	zconf_init_buffer(b,file );
-
-	return b;
-}
-
-/** Destroy the buffer.
- * @param b a buffer created with zconf_create_buffer()
- * 
- */
-    void zconf_delete_buffer (YY_BUFFER_STATE  b )
-{
-    
-	if ( ! b )
-		return;
-
-	if ( b == YY_CURRENT_BUFFER ) /* Not sure if we should pop here. */
-		YY_CURRENT_BUFFER_LVALUE = (YY_BUFFER_STATE) 0;
-
-	if ( b->yy_is_our_buffer )
-		zconffree((void *) b->yy_ch_buf  );
-
-	zconffree((void *) b  );
-}
-
-/* Initializes or reinitializes a buffer.
- * This function is sometimes called more than once on the same buffer,
- * such as during a zconfrestart() or at EOF.
- */
-    static void zconf_init_buffer  (YY_BUFFER_STATE  b, FILE * file )
-
-{
-	int oerrno = errno;
-    
-	zconf_flush_buffer(b );
-
-	b->yy_input_file = file;
-	b->yy_fill_buffer = 1;
-
-    /* If b is the current buffer, then zconf_init_buffer was _probably_
-     * called from zconfrestart() or through yy_get_next_buffer.
-     * In that case, we don't want to reset the lineno or column.
-     */
-    if (b != YY_CURRENT_BUFFER){
-        b->yy_bs_lineno = 1;
-        b->yy_bs_column = 0;
-    }
-
-        b->yy_is_interactive = 0;
-    
-	errno = oerrno;
-}
-
-/** Discard all buffered characters. On the next scan, YY_INPUT will be called.
- * @param b the buffer state to be flushed, usually @c YY_CURRENT_BUFFER.
- * 
- */
-    void zconf_flush_buffer (YY_BUFFER_STATE  b )
-{
-    	if ( ! b )
-		return;
-
-	b->yy_n_chars = 0;
-
-	/* We always need two end-of-buffer characters.  The first causes
-	 * a transition to the end-of-buffer state.  The second causes
-	 * a jam in that state.
-	 */
-	b->yy_ch_buf[0] = YY_END_OF_BUFFER_CHAR;
-	b->yy_ch_buf[1] = YY_END_OF_BUFFER_CHAR;
-
-	b->yy_buf_pos = &b->yy_ch_buf[0];
-
-	b->yy_at_bol = 1;
-	b->yy_buffer_status = YY_BUFFER_NEW;
-
-	if ( b == YY_CURRENT_BUFFER )
-		zconf_load_buffer_state( );
-}
-
-/** Pushes the new state onto the stack. The new state becomes
- *  the current state. This function will allocate the stack
- *  if necessary.
- *  @param new_buffer The new state.
- *  
- */
-void zconfpush_buffer_state (YY_BUFFER_STATE new_buffer )
-{
-    	if (new_buffer == NULL)
-		return;
-
-	zconfensure_buffer_stack();
-
-	/* This block is copied from zconf_switch_to_buffer. */
-	if ( YY_CURRENT_BUFFER )
-		{
-		/* Flush out information for old buffer. */
-		*(yy_c_buf_p) = (yy_hold_char);
-		YY_CURRENT_BUFFER_LVALUE->yy_buf_pos = (yy_c_buf_p);
-		YY_CURRENT_BUFFER_LVALUE->yy_n_chars = (yy_n_chars);
-		}
-
-	/* Only push if top exists. Otherwise, replace top. */
-	if (YY_CURRENT_BUFFER)
-		(yy_buffer_stack_top)++;
-	YY_CURRENT_BUFFER_LVALUE = new_buffer;
-
-	/* copied from zconf_switch_to_buffer. */
-	zconf_load_buffer_state( );
-	(yy_did_buffer_switch_on_eof) = 1;
-}
-
-/** Removes and deletes the top of the stack, if present.
- *  The next element becomes the new top.
- *  
- */
-void zconfpop_buffer_state (void)
-{
-    	if (!YY_CURRENT_BUFFER)
-		return;
-
-	zconf_delete_buffer(YY_CURRENT_BUFFER );
-	YY_CURRENT_BUFFER_LVALUE = NULL;
-	if ((yy_buffer_stack_top) > 0)
-		--(yy_buffer_stack_top);
-
-	if (YY_CURRENT_BUFFER) {
-		zconf_load_buffer_state( );
-		(yy_did_buffer_switch_on_eof) = 1;
-	}
-}
-
-/* Allocates the stack if it does not exist.
- *  Guarantees space for at least one push.
- */
-static void zconfensure_buffer_stack (void)
-{
-	int num_to_alloc;
-    
-	if (!(yy_buffer_stack)) {
-
-		/* First allocation is just for 2 elements, since we don't know if this
-		 * scanner will even need a stack. We use 2 instead of 1 to avoid an
-		 * immediate realloc on the next call.
-         */
-		num_to_alloc = 1;
-		(yy_buffer_stack) = (struct yy_buffer_state**)zconfalloc
-								(num_to_alloc * sizeof(struct yy_buffer_state*)
-								);
-		if ( ! (yy_buffer_stack) )
-			YY_FATAL_ERROR( "out of dynamic memory in zconfensure_buffer_stack()" );
-								  
-		memset((yy_buffer_stack), 0, num_to_alloc * sizeof(struct yy_buffer_state*));
-				
-		(yy_buffer_stack_max) = num_to_alloc;
-		(yy_buffer_stack_top) = 0;
-		return;
-	}
-
-	if ((yy_buffer_stack_top) >= ((yy_buffer_stack_max)) - 1){
-
-		/* Increase the buffer to prepare for a possible push. */
-		int grow_size = 8 /* arbitrary grow size */;
-
-		num_to_alloc = (yy_buffer_stack_max) + grow_size;
-		(yy_buffer_stack) = (struct yy_buffer_state**)zconfrealloc
-								((yy_buffer_stack),
-								num_to_alloc * sizeof(struct yy_buffer_state*)
-								);
-		if ( ! (yy_buffer_stack) )
-			YY_FATAL_ERROR( "out of dynamic memory in zconfensure_buffer_stack()" );
-
-		/* zero only the new slots.*/
-		memset((yy_buffer_stack) + (yy_buffer_stack_max), 0, grow_size * sizeof(struct yy_buffer_state*));
-		(yy_buffer_stack_max) = num_to_alloc;
-	}
-}
-
-/** Setup the input buffer state to scan directly from a user-specified character buffer.
- * @param base the character buffer
- * @param size the size in bytes of the character buffer
- * 
- * @return the newly allocated buffer state object. 
- */
-YY_BUFFER_STATE zconf_scan_buffer  (char * base, yy_size_t  size )
-{
-	YY_BUFFER_STATE b;
-    
-	if ( size < 2 ||
-	     base[size-2] != YY_END_OF_BUFFER_CHAR ||
-	     base[size-1] != YY_END_OF_BUFFER_CHAR )
-		/* They forgot to leave room for the EOB's. */
-		return 0;
-
-	b = (YY_BUFFER_STATE) zconfalloc(sizeof( struct yy_buffer_state )  );
-	if ( ! b )
-		YY_FATAL_ERROR( "out of dynamic memory in zconf_scan_buffer()" );
-
-	b->yy_buf_size = size - 2;	/* "- 2" to take care of EOB's */
-	b->yy_buf_pos = b->yy_ch_buf = base;
-	b->yy_is_our_buffer = 0;
-	b->yy_input_file = 0;
-	b->yy_n_chars = b->yy_buf_size;
-	b->yy_is_interactive = 0;
-	b->yy_at_bol = 1;
-	b->yy_fill_buffer = 0;
-	b->yy_buffer_status = YY_BUFFER_NEW;
-
-	zconf_switch_to_buffer(b  );
-
-	return b;
-}
-
-/** Setup the input buffer state to scan a string. The next call to zconflex() will
- * scan from a @e copy of @a str.
- * @param yystr a NUL-terminated string to scan
- * 
- * @return the newly allocated buffer state object.
- * @note If you want to scan bytes that may contain NUL values, then use
- *       zconf_scan_bytes() instead.
- */
-YY_BUFFER_STATE zconf_scan_string (yyconst char * yystr )
-{
-    
-	return zconf_scan_bytes(yystr,strlen(yystr) );
-}
-
-/** Setup the input buffer state to scan the given bytes. The next call to zconflex() will
- * scan from a @e copy of @a bytes.
- * @param yybytes the byte buffer to scan
- * @param _yybytes_len the number of bytes in the buffer pointed to by @a bytes.
- * 
- * @return the newly allocated buffer state object.
- */
-YY_BUFFER_STATE zconf_scan_bytes  (yyconst char * yybytes, int  _yybytes_len )
-{
-	YY_BUFFER_STATE b;
-	char *buf;
-	yy_size_t n;
-	int i;
-    
-	/* Get memory for full buffer, including space for trailing EOB's. */
-	n = _yybytes_len + 2;
-	buf = (char *) zconfalloc(n  );
-	if ( ! buf )
-		YY_FATAL_ERROR( "out of dynamic memory in zconf_scan_bytes()" );
-
-	for ( i = 0; i < _yybytes_len; ++i )
-		buf[i] = yybytes[i];
-
-	buf[_yybytes_len] = buf[_yybytes_len+1] = YY_END_OF_BUFFER_CHAR;
-
-	b = zconf_scan_buffer(buf,n );
-	if ( ! b )
-		YY_FATAL_ERROR( "bad buffer in zconf_scan_bytes()" );
-
-	/* It's okay to grow etc. this buffer, and we should throw it
-	 * away when we're done.
-	 */
-	b->yy_is_our_buffer = 1;
-
-	return b;
-}
-
-#ifndef YY_EXIT_FAILURE
-#define YY_EXIT_FAILURE 2
-#endif
-
-static void yy_fatal_error (yyconst char* msg )
-{
-    	(void) fprintf( stderr, "%s\n", msg );
-	exit( YY_EXIT_FAILURE );
-}
-
-/* Redefine yyless() so it works in section 3 code. */
-
-#undef yyless
-#define yyless(n) \
-	do \
-		{ \
-		/* Undo effects of setting up zconftext. */ \
-        int yyless_macro_arg = (n); \
-        YY_LESS_LINENO(yyless_macro_arg);\
-		zconftext[zconfleng] = (yy_hold_char); \
-		(yy_c_buf_p) = zconftext + yyless_macro_arg; \
-		(yy_hold_char) = *(yy_c_buf_p); \
-		*(yy_c_buf_p) = '\0'; \
-		zconfleng = yyless_macro_arg; \
-		} \
-	while ( 0 )
-
-/* Accessor  methods (get/set functions) to struct members. */
-
-/** Get the current line number.
- * 
- */
-int zconfget_lineno  (void)
-{
-        
-    return zconflineno;
-}
-
-/** Get the input stream.
- * 
- */
-FILE *zconfget_in  (void)
-{
-        return zconfin;
-}
-
-/** Get the output stream.
- * 
- */
-FILE *zconfget_out  (void)
-{
-        return zconfout;
-}
-
-/** Get the length of the current token.
- * 
- */
-int zconfget_leng  (void)
-{
-        return zconfleng;
-}
-
-/** Get the current token.
- * 
- */
-
-char *zconfget_text  (void)
-{
-        return zconftext;
-}
-
-/** Set the current line number.
- * @param line_number
- * 
- */
-void zconfset_lineno (int  line_number )
-{
-    
-    zconflineno = line_number;
-}
-
-/** Set the input stream. This does not discard the current
- * input buffer.
- * @param in_str A readable stream.
- * 
- * @see zconf_switch_to_buffer
- */
-void zconfset_in (FILE *  in_str )
-{
-        zconfin = in_str ;
-}
-
-void zconfset_out (FILE *  out_str )
-{
-        zconfout = out_str ;
-}
-
-int zconfget_debug  (void)
-{
-        return zconf_flex_debug;
-}
-
-void zconfset_debug (int  bdebug )
-{
-        zconf_flex_debug = bdebug ;
-}
-
-static int yy_init_globals (void)
-{
-        /* Initialization is the same as for the non-reentrant scanner.
-     * This function is called from zconflex_destroy(), so don't allocate here.
-     */
-
-    (yy_buffer_stack) = 0;
-    (yy_buffer_stack_top) = 0;
-    (yy_buffer_stack_max) = 0;
-    (yy_c_buf_p) = (char *) 0;
-    (yy_init) = 0;
-    (yy_start) = 0;
-
-/* Defined in main.c */
-#ifdef YY_STDINIT
-    zconfin = stdin;
-    zconfout = stdout;
-#else
-    zconfin = (FILE *) 0;
-    zconfout = (FILE *) 0;
-#endif
-
-    /* For future reference: Set errno on error, since we are called by
-     * zconflex_init()
-     */
-    return 0;
-}
-
-/* zconflex_destroy is for both reentrant and non-reentrant scanners. */
-int zconflex_destroy  (void)
-{
-    
-    /* Pop the buffer stack, destroying each element. */
-	while(YY_CURRENT_BUFFER){
-		zconf_delete_buffer(YY_CURRENT_BUFFER  );
-		YY_CURRENT_BUFFER_LVALUE = NULL;
-		zconfpop_buffer_state();
-	}
-
-	/* Destroy the stack itself. */
-	zconffree((yy_buffer_stack) );
-	(yy_buffer_stack) = NULL;
-
-    /* Reset the globals. This is important in a non-reentrant scanner so the next time
-     * zconflex() is called, initialization will occur. */
-    yy_init_globals( );
-
-    return 0;
-}
-
-/*
- * Internal utility routines.
- */
-
-#ifndef yytext_ptr
-static void yy_flex_strncpy (char* s1, yyconst char * s2, int n )
-{
-	register int i;
-	for ( i = 0; i < n; ++i )
-		s1[i] = s2[i];
-}
-#endif
-
-#ifdef YY_NEED_STRLEN
-static int yy_flex_strlen (yyconst char * s )
-{
-	register int n;
-	for ( n = 0; s[n]; ++n )
-		;
-
-	return n;
-}
-#endif
-
-void *zconfalloc (yy_size_t  size )
-{
-	return (void *) malloc( size );
-}
-
-void *zconfrealloc  (void * ptr, yy_size_t  size )
-{
-	/* The cast to (char *) in the following accommodates both
-	 * implementations that use char* generic pointers, and those
-	 * that use void* generic pointers.  It works with the latter
-	 * because both ANSI C and C++ allow castless assignment from
-	 * any pointer type to void*, and deal with argument conversions
-	 * as though doing an assignment.
-	 */
-	return (void *) realloc( (char *) ptr, size );
-}
-
-void zconffree (void * ptr )
-{
-	free( (char *) ptr );	/* see zconfrealloc() for (char *) cast */
-}
-
-#define YYTABLES_NAME "yytables"
-
-void zconf_starthelp(void)
-{
-	new_string();
-	last_ts = first_ts = 0;
-	BEGIN(HELP);
-}
-
-static void zconf_endhelp(void)
-{
-	zconflval.string = text;
-	BEGIN(INITIAL);
-}
-
-/*
- * Try to open specified file with following names:
- * ./name
- * $(srctree)/name
- * The latter is used when srctree is separate from objtree
- * when compiling the kernel.
- * Return NULL if file is not found.
- */
-FILE *zconf_fopen(const char *name)
-{
-	char *env, fullname[PATH_MAX+1];
-	FILE *f;
-
-	f = fopen(name, "r");
-	if (!f && name != NULL && name[0] != '/') {
-		env = getenv(SRCTREE);
-		if (env) {
-			sprintf(fullname, "%s/%s", env, name);
-			f = fopen(fullname, "r");
-		}
-	}
-	return f;
-}
-
-void zconf_initscan(const char *name)
-{
-	zconfin = zconf_fopen(name);
-	if (!zconfin) {
-		printf("can't find file %s\n", name);
-		exit(1);
-	}
-
-	current_buf = xmalloc(sizeof(*current_buf));
-	memset(current_buf, 0, sizeof(*current_buf));
-
-	current_file = file_lookup(name);
-	current_file->lineno = 1;
-}
-
-void zconf_nextfile(const char *name)
-{
-	struct file *iter;
-	struct file *file = file_lookup(name);
-	struct buffer *buf = xmalloc(sizeof(*buf));
-	memset(buf, 0, sizeof(*buf));
-
-	current_buf->state = YY_CURRENT_BUFFER;
-	zconfin = zconf_fopen(file->name);
-	if (!zconfin) {
-		printf("%s:%d: can't open file \"%s\"\n",
-		    zconf_curname(), zconf_lineno(), file->name);
-		exit(1);
-	}
-	zconf_switch_to_buffer(zconf_create_buffer(zconfin,YY_BUF_SIZE));
-	buf->parent = current_buf;
-	current_buf = buf;
-
-	for (iter = current_file->parent; iter; iter = iter->parent ) {
-		if (!strcmp(current_file->name,iter->name) ) {
-			printf("%s:%d: recursive inclusion detected. "
-			       "Inclusion path:\n  current file : '%s'\n",
-			       zconf_curname(), zconf_lineno(),
-			       zconf_curname());
-			iter = current_file->parent;
-			while (iter && \
-			       strcmp(iter->name,current_file->name)) {
-				printf("  included from: '%s:%d'\n",
-				       iter->name, iter->lineno-1);
-				iter = iter->parent;
-			}
-			if (iter)
-				printf("  included from: '%s:%d'\n",
-				       iter->name, iter->lineno+1);
-			exit(1);
-		}
-	}
-	file->lineno = 1;
-	file->parent = current_file;
-	current_file = file;
-}
-
-static void zconf_endfile(void)
-{
-	struct buffer *parent;
-
-	current_file = current_file->parent;
-
-	parent = current_buf->parent;
-	if (parent) {
-		fclose(zconfin);
-		zconf_delete_buffer(YY_CURRENT_BUFFER);
-		zconf_switch_to_buffer(parent->state);
-	}
-	free(current_buf);
-	current_buf = parent;
-}
-
-int zconf_lineno(void)
-{
-	return current_pos.lineno;
-}
-
-const char *zconf_curname(void)
-{
-	return current_pos.file ? current_pos.file->name : "<none>";
-}
-
diff --git a/backport/kconf/zconf.tab.c b/backport/kconf/zconf.tab.c
deleted file mode 100644
index 65b7515a..00000000
--- a/backport/kconf/zconf.tab.c
+++ /dev/null
@@ -1,2471 +0,0 @@
-/* A Bison parser, made by GNU Bison 3.0.4.  */
-
-/* Bison implementation for Yacc-like parsers in C
-
-   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.
-
-   This program is free software: you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation, either version 3 of the License, or
-   (at your option) any later version.
-
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
-
-/* As a special exception, you may create a larger work that contains
-   part or all of the Bison parser skeleton and distribute that work
-   under terms of your choice, so long as that work isn't itself a
-   parser generator using the skeleton or a modified version thereof
-   as a parser skeleton.  Alternatively, if you modify or redistribute
-   the parser skeleton itself, you may (at your option) remove this
-   special exception, which will cause the skeleton and the resulting
-   Bison output files to be licensed under the GNU General Public
-   License without this special exception.
-
-   This special exception was added by the Free Software Foundation in
-   version 2.2 of Bison.  */
-
-/* C LALR(1) parser skeleton written by Richard Stallman, by
-   simplifying the original so-called "semantic" parser.  */
-
-/* All symbols defined below should begin with yy or YY, to avoid
-   infringing on user name space.  This should be done even for local
-   variables, as they might otherwise be expanded by user macros.
-   There are some unavoidable exceptions within include files to
-   define necessary library symbols; they are noted "INFRINGES ON
-   USER NAME SPACE" below.  */
-
-/* Identify Bison output.  */
-#define YYBISON 1
-
-/* Bison version.  */
-#define YYBISON_VERSION "3.0.4"
-
-/* Skeleton name.  */
-#define YYSKELETON_NAME "yacc.c"
-
-/* Pure parsers.  */
-#define YYPURE 0
-
-/* Push parsers.  */
-#define YYPUSH 0
-
-/* Pull parsers.  */
-#define YYPULL 1
-
-
-/* Substitute the variable and function names.  */
-#define yyparse         zconfparse
-#define yylex           zconflex
-#define yyerror         zconferror
-#define yydebug         zconfdebug
-#define yynerrs         zconfnerrs
-
-#define yylval          zconflval
-#define yychar          zconfchar
-
-/* Copy the first part of user declarations.  */
-
-
-/*
- * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
- * Released under the terms of the GNU GPL v2.0.
- */
-
-#include <ctype.h>
-#include <stdarg.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <stdbool.h>
-
-#include "lkc.h"
-
-#define printd(mask, fmt...) if (cdebug & (mask)) printf(fmt)
-
-#define PRINTD		0x0001
-#define DEBUG_PARSE	0x0002
-
-int cdebug = PRINTD;
-
-extern int zconflex(void);
-static void zconfprint(const char *err, ...);
-static void zconf_error(const char *err, ...);
-static void zconferror(const char *err);
-static bool zconf_endtoken(const struct kconf_id *id, int starttoken, int endtoken);
-
-struct symbol *symbol_hash[SYMBOL_HASHSIZE];
-
-static struct menu *current_menu, *current_entry;
-
-
-
-
-# ifndef YY_NULLPTR
-#  if defined __cplusplus && 201103L <= __cplusplus
-#   define YY_NULLPTR nullptr
-#  else
-#   define YY_NULLPTR 0
-#  endif
-# endif
-
-/* Enabling verbose error messages.  */
-#ifdef YYERROR_VERBOSE
-# undef YYERROR_VERBOSE
-# define YYERROR_VERBOSE 1
-#else
-# define YYERROR_VERBOSE 0
-#endif
-
-
-/* Debug traces.  */
-#ifndef YYDEBUG
-# define YYDEBUG 1
-#endif
-#if YYDEBUG
-extern int zconfdebug;
-#endif
-
-/* Token type.  */
-#ifndef YYTOKENTYPE
-# define YYTOKENTYPE
-  enum yytokentype
-  {
-    T_MAINMENU = 258,
-    T_MENU = 259,
-    T_ENDMENU = 260,
-    T_SOURCE = 261,
-    T_CHOICE = 262,
-    T_ENDCHOICE = 263,
-    T_COMMENT = 264,
-    T_CONFIG = 265,
-    T_MENUCONFIG = 266,
-    T_HELP = 267,
-    T_HELPTEXT = 268,
-    T_IF = 269,
-    T_ENDIF = 270,
-    T_DEPENDS = 271,
-    T_OPTIONAL = 272,
-    T_PROMPT = 273,
-    T_TYPE = 274,
-    T_DEFAULT = 275,
-    T_SELECT = 276,
-    T_IMPLY = 277,
-    T_RANGE = 278,
-    T_VISIBLE = 279,
-    T_OPTION = 280,
-    T_ON = 281,
-    T_WORD = 282,
-    T_WORD_QUOTE = 283,
-    T_UNEQUAL = 284,
-    T_LESS = 285,
-    T_LESS_EQUAL = 286,
-    T_GREATER = 287,
-    T_GREATER_EQUAL = 288,
-    T_CLOSE_PAREN = 289,
-    T_OPEN_PAREN = 290,
-    T_EOL = 291,
-    T_OR = 292,
-    T_AND = 293,
-    T_EQUAL = 294,
-    T_NOT = 295
-  };
-#endif
-
-/* Value type.  */
-#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
-
-union YYSTYPE
-{
-
-
-	char *string;
-	struct file *file;
-	struct symbol *symbol;
-	struct expr *expr;
-	struct menu *menu;
-	const struct kconf_id *id;
-
-
-};
-
-typedef union YYSTYPE YYSTYPE;
-# define YYSTYPE_IS_TRIVIAL 1
-# define YYSTYPE_IS_DECLARED 1
-#endif
-
-
-extern YYSTYPE zconflval;
-
-int zconfparse (void);
-
-
-
-/* Copy the second part of user declarations.  */
-
-
-/* Include zconf.hash.c here so it can see the token constants. */
-#include "zconf.hash.c"
-
-
-
-#ifdef short
-# undef short
-#endif
-
-#ifdef YYTYPE_UINT8
-typedef YYTYPE_UINT8 yytype_uint8;
-#else
-typedef unsigned char yytype_uint8;
-#endif
-
-#ifdef YYTYPE_INT8
-typedef YYTYPE_INT8 yytype_int8;
-#else
-typedef signed char yytype_int8;
-#endif
-
-#ifdef YYTYPE_UINT16
-typedef YYTYPE_UINT16 yytype_uint16;
-#else
-typedef unsigned short int yytype_uint16;
-#endif
-
-#ifdef YYTYPE_INT16
-typedef YYTYPE_INT16 yytype_int16;
-#else
-typedef short int yytype_int16;
-#endif
-
-#ifndef YYSIZE_T
-# ifdef __SIZE_TYPE__
-#  define YYSIZE_T __SIZE_TYPE__
-# elif defined size_t
-#  define YYSIZE_T size_t
-# elif ! defined YYSIZE_T
-#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
-#  define YYSIZE_T size_t
-# else
-#  define YYSIZE_T unsigned int
-# endif
-#endif
-
-#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)
-
-#ifndef YY_
-# if defined YYENABLE_NLS && YYENABLE_NLS
-#  if ENABLE_NLS
-#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
-#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
-#  endif
-# endif
-# ifndef YY_
-#  define YY_(Msgid) Msgid
-# endif
-#endif
-
-#ifndef YY_ATTRIBUTE
-# if (defined __GNUC__                                               \
-      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
-     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
-#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
-# else
-#  define YY_ATTRIBUTE(Spec) /* empty */
-# endif
-#endif
-
-#ifndef YY_ATTRIBUTE_PURE
-# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
-#endif
-
-#ifndef YY_ATTRIBUTE_UNUSED
-# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
-#endif
-
-#if !defined _Noreturn \
-     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
-# if defined _MSC_VER && 1200 <= _MSC_VER
-#  define _Noreturn __declspec (noreturn)
-# else
-#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
-# endif
-#endif
-
-/* Suppress unused-variable warnings by "using" E.  */
-#if ! defined lint || defined __GNUC__
-# define YYUSE(E) ((void) (E))
-#else
-# define YYUSE(E) /* empty */
-#endif
-
-#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
-/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
-# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
-    _Pragma ("GCC diagnostic push") \
-    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
-    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
-# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
-    _Pragma ("GCC diagnostic pop")
-#else
-# define YY_INITIAL_VALUE(Value) Value
-#endif
-#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
-# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
-# define YY_IGNORE_MAYBE_UNINITIALIZED_END
-#endif
-#ifndef YY_INITIAL_VALUE
-# define YY_INITIAL_VALUE(Value) /* Nothing. */
-#endif
-
-
-#if ! defined yyoverflow || YYERROR_VERBOSE
-
-/* The parser invokes alloca or malloc; define the necessary symbols.  */
-
-# ifdef YYSTACK_USE_ALLOCA
-#  if YYSTACK_USE_ALLOCA
-#   ifdef __GNUC__
-#    define YYSTACK_ALLOC __builtin_alloca
-#   elif defined __BUILTIN_VA_ARG_INCR
-#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
-#   elif defined _AIX
-#    define YYSTACK_ALLOC __alloca
-#   elif defined _MSC_VER
-#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
-#    define alloca _alloca
-#   else
-#    define YYSTACK_ALLOC alloca
-#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
-#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
-      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
-#     ifndef EXIT_SUCCESS
-#      define EXIT_SUCCESS 0
-#     endif
-#    endif
-#   endif
-#  endif
-# endif
-
-# ifdef YYSTACK_ALLOC
-   /* Pacify GCC's 'empty if-body' warning.  */
-#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
-#  ifndef YYSTACK_ALLOC_MAXIMUM
-    /* The OS might guarantee only one guard page at the bottom of the stack,
-       and a page size can be as small as 4096 bytes.  So we cannot safely
-       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
-       to allow for a few compiler-allocated temporary stack slots.  */
-#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
-#  endif
-# else
-#  define YYSTACK_ALLOC YYMALLOC
-#  define YYSTACK_FREE YYFREE
-#  ifndef YYSTACK_ALLOC_MAXIMUM
-#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
-#  endif
-#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
-       && ! ((defined YYMALLOC || defined malloc) \
-             && (defined YYFREE || defined free)))
-#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
-#   ifndef EXIT_SUCCESS
-#    define EXIT_SUCCESS 0
-#   endif
-#  endif
-#  ifndef YYMALLOC
-#   define YYMALLOC malloc
-#   if ! defined malloc && ! defined EXIT_SUCCESS
-void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
-#   endif
-#  endif
-#  ifndef YYFREE
-#   define YYFREE free
-#   if ! defined free && ! defined EXIT_SUCCESS
-void free (void *); /* INFRINGES ON USER NAME SPACE */
-#   endif
-#  endif
-# endif
-#endif /* ! defined yyoverflow || YYERROR_VERBOSE */
-
-
-#if (! defined yyoverflow \
-     && (! defined __cplusplus \
-         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))
-
-/* A type that is properly aligned for any stack member.  */
-union yyalloc
-{
-  yytype_int16 yyss_alloc;
-  YYSTYPE yyvs_alloc;
-};
-
-/* The size of the maximum gap between one aligned stack and the next.  */
-# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)
-
-/* The size of an array large to enough to hold all stacks, each with
-   N elements.  */
-# define YYSTACK_BYTES(N) \
-     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
-      + YYSTACK_GAP_MAXIMUM)
-
-# define YYCOPY_NEEDED 1
-
-/* Relocate STACK from its old location to the new one.  The
-   local variables YYSIZE and YYSTACKSIZE give the old and new number of
-   elements in the stack, and YYPTR gives the new location of the
-   stack.  Advance YYPTR to a properly aligned location for the next
-   stack.  */
-# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
-    do                                                                  \
-      {                                                                 \
-        YYSIZE_T yynewbytes;                                            \
-        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
-        Stack = &yyptr->Stack_alloc;                                    \
-        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
-        yyptr += yynewbytes / sizeof (*yyptr);                          \
-      }                                                                 \
-    while (0)
-
-#endif
-
-#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
-/* Copy COUNT objects from SRC to DST.  The source and destination do
-   not overlap.  */
-# ifndef YYCOPY
-#  if defined __GNUC__ && 1 < __GNUC__
-#   define YYCOPY(Dst, Src, Count) \
-      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
-#  else
-#   define YYCOPY(Dst, Src, Count)              \
-      do                                        \
-        {                                       \
-          YYSIZE_T yyi;                         \
-          for (yyi = 0; yyi < (Count); yyi++)   \
-            (Dst)[yyi] = (Src)[yyi];            \
-        }                                       \
-      while (0)
-#  endif
-# endif
-#endif /* !YYCOPY_NEEDED */
-
-/* YYFINAL -- State number of the termination state.  */
-#define YYFINAL  11
-/* YYLAST -- Last index in YYTABLE.  */
-#define YYLAST   301
-
-/* YYNTOKENS -- Number of terminals.  */
-#define YYNTOKENS  41
-/* YYNNTS -- Number of nonterminals.  */
-#define YYNNTS  50
-/* YYNRULES -- Number of rules.  */
-#define YYNRULES  124
-/* YYNSTATES -- Number of states.  */
-#define YYNSTATES  204
-
-/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
-   by yylex, with out-of-bounds checking.  */
-#define YYUNDEFTOK  2
-#define YYMAXUTOK   295
-
-#define YYTRANSLATE(YYX)                                                \
-  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)
-
-/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
-   as returned by yylex, without out-of-bounds checking.  */
-static const yytype_uint8 yytranslate[] =
-{
-       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
-       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
-       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
-      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
-      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
-      35,    36,    37,    38,    39,    40
-};
-
-#if YYDEBUG
-  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
-static const yytype_uint16 yyrline[] =
-{
-       0,   109,   109,   109,   111,   111,   113,   115,   116,   117,
-     118,   119,   120,   124,   128,   128,   128,   128,   128,   128,
-     128,   128,   128,   132,   133,   134,   135,   136,   137,   141,
-     142,   148,   156,   162,   170,   180,   182,   183,   184,   185,
-     186,   187,   190,   198,   204,   214,   220,   226,   232,   235,
-     237,   248,   249,   254,   263,   268,   276,   279,   281,   282,
-     283,   284,   285,   288,   294,   305,   311,   321,   323,   328,
-     336,   344,   347,   349,   350,   351,   356,   363,   370,   375,
-     383,   386,   388,   389,   390,   393,   401,   408,   415,   421,
-     428,   430,   431,   432,   435,   443,   445,   446,   449,   456,
-     458,   463,   464,   467,   468,   469,   473,   474,   477,   478,
-     481,   482,   483,   484,   485,   486,   487,   488,   489,   490,
-     491,   494,   495,   498,   499
-};
-#endif
-
-#if YYDEBUG || YYERROR_VERBOSE || 0
-/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
-   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
-static const char *const yytname[] =
-{
-  "$end", "error", "$undefined", "T_MAINMENU", "T_MENU", "T_ENDMENU",
-  "T_SOURCE", "T_CHOICE", "T_ENDCHOICE", "T_COMMENT", "T_CONFIG",
-  "T_MENUCONFIG", "T_HELP", "T_HELPTEXT", "T_IF", "T_ENDIF", "T_DEPENDS",
-  "T_OPTIONAL", "T_PROMPT", "T_TYPE", "T_DEFAULT", "T_SELECT", "T_IMPLY",
-  "T_RANGE", "T_VISIBLE", "T_OPTION", "T_ON", "T_WORD", "T_WORD_QUOTE",
-  "T_UNEQUAL", "T_LESS", "T_LESS_EQUAL", "T_GREATER", "T_GREATER_EQUAL",
-  "T_CLOSE_PAREN", "T_OPEN_PAREN", "T_EOL", "T_OR", "T_AND", "T_EQUAL",
-  "T_NOT", "$accept", "input", "start", "stmt_list", "option_name",
-  "common_stmt", "option_error", "config_entry_start", "config_stmt",
-  "menuconfig_entry_start", "menuconfig_stmt", "config_option_list",
-  "config_option", "symbol_option", "symbol_option_list",
-  "symbol_option_arg", "choice", "choice_entry", "choice_end",
-  "choice_stmt", "choice_option_list", "choice_option", "choice_block",
-  "if_entry", "if_end", "if_stmt", "if_block", "mainmenu_stmt", "menu",
-  "menu_entry", "menu_end", "menu_stmt", "menu_block", "source_stmt",
-  "comment", "comment_stmt", "help_start", "help", "depends_list",
-  "depends", "visibility_list", "visible", "prompt_stmt_opt", "prompt",
-  "end", "nl", "if_expr", "expr", "symbol", "word_opt", YY_NULLPTR
-};
-#endif
-
-# ifdef YYPRINT
-/* YYTOKNUM[NUM] -- (External) token number corresponding to the
-   (internal) symbol number NUM (which must be that of a token).  */
-static const yytype_uint16 yytoknum[] =
-{
-       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
-     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
-     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
-     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
-     295
-};
-# endif
-
-#define YYPACT_NINF -92
-
-#define yypact_value_is_default(Yystate) \
-  (!!((Yystate) == (-92)))
-
-#define YYTABLE_NINF -88
-
-#define yytable_value_is_error(Yytable_value) \
-  0
-
-  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
-     STATE-NUM.  */
-static const yytype_int16 yypact[] =
-{
-      17,    41,   -92,    15,   -92,   150,   -92,    19,   -92,   -92,
-     -13,   -92,    28,    41,    38,    41,    50,    47,    41,    79,
-      82,    44,    76,   -92,   -92,   -92,   -92,   -92,   -92,   -92,
-     -92,   -92,   118,   -92,   129,   -92,   -92,   -92,   -92,   -92,
-     -92,   -92,   -92,   -92,   -92,   -92,   -92,   -92,   -92,   -92,
-     -92,   -92,   184,   -92,   -92,   107,   -92,   111,   -92,   113,
-     -92,   116,   -92,   139,   140,   151,   -92,   -92,    44,    44,
-     142,   256,   -92,   160,   173,    27,   117,    80,    51,   255,
-     -15,   255,   217,   -92,   -92,   -92,   -92,   -92,   -92,    -8,
-     -92,    44,    44,   107,    87,    87,    87,    87,    87,    87,
-     -92,   -92,   174,   176,   187,    41,    41,    44,   188,   189,
-      87,   -92,   213,   -92,   -92,   -92,   -92,   206,   -92,   -92,
-     193,    41,    41,   203,   -92,   -92,   -92,   -92,   -92,   -92,
-     -92,   -92,   -92,   -92,   -92,   -92,   -92,   229,   -92,   241,
-     -92,   -92,   -92,   -92,   -92,   -92,   -92,   -92,   -92,   -92,
-     216,   -92,   -92,   -92,   -92,   -92,   -92,   -92,   -92,   -92,
-      44,   229,   222,   229,    64,   229,   229,    87,    31,   231,
-     -92,   -92,   229,   236,   229,    44,   -92,   145,   242,   -92,
-     -92,   243,   244,   245,   229,   251,   -92,   -92,   247,   -92,
-     257,   125,   -92,   -92,   -92,   -92,   -92,   260,    41,   -92,
-     -92,   -92,   -92,   -92
-};
-
-  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
-     Performed when YYTABLE does not specify something else to do.  Zero
-     means the default is an error.  */
-static const yytype_uint8 yydefact[] =
-{
-       6,     0,   106,     0,     3,     0,     6,     6,   101,   102,
-       0,     1,     0,     0,     0,     0,   123,     0,     0,     0,
-       0,     0,     0,    14,    19,    15,    16,    21,    17,    18,
-      20,    22,     0,    23,     0,     7,    35,    26,    35,    27,
-      57,    67,     8,    72,    24,    95,    81,     9,    28,    90,
-      25,    10,     0,   107,     2,    76,    13,     0,   103,     0,
-     124,     0,   104,     0,     0,     0,   121,   122,     0,     0,
-       0,   110,   105,     0,     0,     0,     0,     0,     0,     0,
-      90,     0,     0,    77,    85,    53,    86,    31,    33,     0,
-     118,     0,     0,    69,     0,     0,     0,     0,     0,     0,
-      11,    12,     0,     0,     0,     0,    99,     0,     0,     0,
-       0,    49,     0,    41,    40,    36,    37,     0,    39,    38,
-       0,     0,    99,     0,    61,    62,    58,    60,    59,    68,
-      56,    55,    73,    75,    71,    74,    70,   108,    97,     0,
-      96,    82,    84,    80,    83,    79,    92,    93,    91,   117,
-     119,   120,   116,   111,   112,   113,   114,   115,    30,    88,
-       0,   108,     0,   108,   108,   108,   108,     0,     0,     0,
-      89,    65,   108,     0,   108,     0,    98,     0,     0,    42,
-     100,     0,     0,     0,   108,    51,    48,    29,     0,    64,
-       0,   109,    94,    43,    44,    45,    46,     0,     0,    50,
-      63,    66,    47,    52
-};
-
-  /* YYPGOTO[NTERM-NUM].  */
-static const yytype_int16 yypgoto[] =
-{
-     -92,   -92,   285,   291,   -92,    32,   -66,   -92,   -92,   -92,
-     -92,   261,   -92,   -92,   -92,   -92,   -92,   -92,   -92,     1,
-     -92,   -92,   -92,   -92,   -92,   -92,   -92,   -92,   -92,   -92,
-     -92,    24,   -92,   -92,   -92,   -92,   -92,   221,   220,   -64,
-     -92,   -92,   179,    -1,    67,     0,   110,   -67,   -91,   -92
-};
-
-  /* YYDEFGOTO[NTERM-NUM].  */
-static const yytype_int16 yydefgoto[] =
-{
-      -1,     3,     4,     5,    34,    35,   114,    36,    37,    38,
-      39,    75,   115,   116,   168,   199,    40,    41,   130,    42,
-      77,   126,    78,    43,   134,    44,    79,     6,    45,    46,
-     143,    47,    81,    48,    49,    50,   117,   118,    82,   119,
-      80,   140,   162,   163,    51,     7,   176,    70,    71,    61
-};
-
-  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
-     positive, shift that token.  If negative, reduce the rule whose
-     number is the opposite.  If YYTABLE_NINF, syntax error.  */
-static const yytype_int16 yytable[] =
-{
-      10,    89,    90,   152,   153,   154,   155,   156,   157,   137,
-      55,   125,    57,   128,    59,    11,   147,    63,   148,   167,
-       1,   138,     1,     2,   150,   151,   149,   -32,   102,    91,
-      92,   -32,   -32,   -32,   -32,   -32,   -32,   -32,   -32,   103,
-     164,   -32,   -32,   104,   -32,   105,   106,   107,   108,   109,
-     110,   -32,   111,     2,   112,    53,    14,    15,   185,    17,
-      18,    19,    20,   113,    56,    21,    22,   186,     8,     9,
-      93,    66,    67,   147,    58,   148,   184,    60,   175,    68,
-     133,   102,   142,    62,    69,   -54,   -54,    33,   -54,   -54,
-     -54,   -54,   103,   177,   -54,   -54,   104,   120,   121,   122,
-     123,    91,    92,   135,   161,   144,    64,   112,   191,    65,
-     129,   132,    72,   141,    66,    67,   124,   -34,   102,    73,
-     172,   -34,   -34,   -34,   -34,   -34,   -34,   -34,   -34,   103,
-      74,   -34,   -34,   104,   -34,   105,   106,   107,   108,   109,
-     110,   -34,   111,    53,   112,   131,   136,    83,   145,    84,
-      -5,    12,    85,   113,    13,    14,    15,    16,    17,    18,
-      19,    20,    91,    92,    21,    22,    23,    24,    25,    26,
-      27,    28,    29,    30,    31,    86,    87,    32,     2,    91,
-      92,   192,    91,    92,    -4,    12,    33,    88,    13,    14,
-      15,    16,    17,    18,    19,    20,   100,   203,    21,    22,
-      23,    24,    25,    26,    27,    28,    29,    30,    31,   101,
-     158,    32,   159,   160,   169,   165,   166,   -87,   102,   170,
-      33,   -87,   -87,   -87,   -87,   -87,   -87,   -87,   -87,   171,
-     174,   -87,   -87,   104,   -87,   -87,   -87,   -87,   -87,   -87,
-     -87,   -87,   102,   175,   112,   -78,   -78,   -78,   -78,   -78,
-     -78,   -78,   -78,   146,    92,   -78,   -78,   104,   179,    13,
-      14,    15,    16,    17,    18,    19,    20,   187,   112,    21,
-      22,   178,   189,   180,   181,   182,   183,   146,   193,   194,
-     195,   196,   188,   200,   190,    94,    95,    96,    97,    98,
-     198,    33,    54,   201,   197,    99,   202,    52,   127,    76,
-     139,   173
-};
-
-static const yytype_uint8 yycheck[] =
-{
-       1,    68,    69,    94,    95,    96,    97,    98,    99,    24,
-      10,    77,    13,    77,    15,     0,    82,    18,    82,   110,
-       3,    36,     3,    36,    91,    92,    34,     0,     1,    37,
-      38,     4,     5,     6,     7,     8,     9,    10,    11,    12,
-     107,    14,    15,    16,    17,    18,    19,    20,    21,    22,
-      23,    24,    25,    36,    27,    36,     5,     6,    27,     8,
-       9,    10,    11,    36,    36,    14,    15,    36,    27,    28,
-      70,    27,    28,   139,    36,   139,   167,    27,    14,    35,
-      79,     1,    81,    36,    40,     5,     6,    36,     8,     9,
-      10,    11,    12,   160,    14,    15,    16,    17,    18,    19,
-      20,    37,    38,    79,   105,    81,    27,    27,   175,    27,
-      78,    79,    36,    81,    27,    28,    36,     0,     1,     1,
-     121,     4,     5,     6,     7,     8,     9,    10,    11,    12,
-       1,    14,    15,    16,    17,    18,    19,    20,    21,    22,
-      23,    24,    25,    36,    27,    78,    79,    36,    81,    36,
-       0,     1,    36,    36,     4,     5,     6,     7,     8,     9,
-      10,    11,    37,    38,    14,    15,    16,    17,    18,    19,
-      20,    21,    22,    23,    24,    36,    36,    27,    36,    37,
-      38,    36,    37,    38,     0,     1,    36,    36,     4,     5,
-       6,     7,     8,     9,    10,    11,    36,   198,    14,    15,
-      16,    17,    18,    19,    20,    21,    22,    23,    24,    36,
-      36,    27,    36,    26,     1,    27,    27,     0,     1,    13,
-      36,     4,     5,     6,     7,     8,     9,    10,    11,    36,
-      27,    14,    15,    16,    17,    18,    19,    20,    21,    22,
-      23,    24,     1,    14,    27,     4,     5,     6,     7,     8,
-       9,    10,    11,    36,    38,    14,    15,    16,    36,     4,
-       5,     6,     7,     8,     9,    10,    11,    36,    27,    14,
-      15,   161,    36,   163,   164,   165,   166,    36,    36,    36,
-      36,    36,   172,    36,   174,    29,    30,    31,    32,    33,
-      39,    36,     7,    36,   184,    39,    36,     6,    77,    38,
-      80,   122
-};
-
-  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
-     symbol of state STATE-NUM.  */
-static const yytype_uint8 yystos[] =
-{
-       0,     3,    36,    42,    43,    44,    68,    86,    27,    28,
-      84,     0,     1,     4,     5,     6,     7,     8,     9,    10,
-      11,    14,    15,    16,    17,    18,    19,    20,    21,    22,
-      23,    24,    27,    36,    45,    46,    48,    49,    50,    51,
-      57,    58,    60,    64,    66,    69,    70,    72,    74,    75,
-      76,    85,    44,    36,    43,    86,    36,    84,    36,    84,
-      27,    90,    36,    84,    27,    27,    27,    28,    35,    40,
-      88,    89,    36,     1,     1,    52,    52,    61,    63,    67,
-      81,    73,    79,    36,    36,    36,    36,    36,    36,    88,
-      88,    37,    38,    86,    29,    30,    31,    32,    33,    39,
-      36,    36,     1,    12,    16,    18,    19,    20,    21,    22,
-      23,    25,    27,    36,    47,    53,    54,    77,    78,    80,
-      17,    18,    19,    20,    36,    47,    62,    78,    80,    46,
-      59,    85,    46,    60,    65,    72,    85,    24,    36,    79,
-      82,    46,    60,    71,    72,    85,    36,    47,    80,    34,
-      88,    88,    89,    89,    89,    89,    89,    89,    36,    36,
-      26,    84,    83,    84,    88,    27,    27,    89,    55,     1,
-      13,    36,    84,    83,    27,    14,    87,    88,    87,    36,
-      87,    87,    87,    87,    89,    27,    36,    36,    87,    36,
-      87,    88,    36,    36,    36,    36,    36,    87,    39,    56,
-      36,    36,    36,    84
-};
-
-  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
-static const yytype_uint8 yyr1[] =
-{
-       0,    41,    42,    42,    43,    43,    44,    44,    44,    44,
-      44,    44,    44,    44,    45,    45,    45,    45,    45,    45,
-      45,    45,    45,    46,    46,    46,    46,    46,    46,    47,
-      47,    48,    49,    50,    51,    52,    52,    52,    52,    52,
-      52,    52,    53,    53,    53,    53,    53,    53,    54,    55,
-      55,    56,    56,    57,    58,    59,    60,    61,    61,    61,
-      61,    61,    61,    62,    62,    62,    62,    63,    63,    64,
-      65,    66,    67,    67,    67,    67,    68,    69,    70,    71,
-      72,    73,    73,    73,    73,    74,    75,    76,    77,    78,
-      79,    79,    79,    79,    80,    81,    81,    81,    82,    83,
-      83,    84,    84,    85,    85,    85,    86,    86,    87,    87,
-      88,    88,    88,    88,    88,    88,    88,    88,    88,    88,
-      88,    89,    89,    90,    90
-};
-
-  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
-static const yytype_uint8 yyr2[] =
-{
-       0,     2,     2,     1,     2,     1,     0,     2,     2,     2,
-       2,     4,     4,     3,     1,     1,     1,     1,     1,     1,
-       1,     1,     1,     1,     1,     1,     1,     1,     1,     3,
-       2,     3,     2,     3,     2,     0,     2,     2,     2,     2,
-       2,     2,     3,     4,     4,     4,     4,     5,     3,     0,
-       3,     0,     2,     3,     2,     1,     3,     0,     2,     2,
-       2,     2,     2,     4,     3,     2,     4,     0,     2,     3,
-       1,     3,     0,     2,     2,     2,     3,     3,     3,     1,
-       3,     0,     2,     2,     2,     3,     3,     2,     2,     2,
-       0,     2,     2,     2,     4,     0,     2,     2,     2,     0,
-       2,     1,     1,     2,     2,     2,     1,     2,     0,     2,
-       1,     3,     3,     3,     3,     3,     3,     3,     2,     3,
-       3,     1,     1,     0,     1
-};
-
-
-#define yyerrok         (yyerrstatus = 0)
-#define yyclearin       (yychar = YYEMPTY)
-#define YYEMPTY         (-2)
-#define YYEOF           0
-
-#define YYACCEPT        goto yyacceptlab
-#define YYABORT         goto yyabortlab
-#define YYERROR         goto yyerrorlab
-
-
-#define YYRECOVERING()  (!!yyerrstatus)
-
-#define YYBACKUP(Token, Value)                                  \
-do                                                              \
-  if (yychar == YYEMPTY)                                        \
-    {                                                           \
-      yychar = (Token);                                         \
-      yylval = (Value);                                         \
-      YYPOPSTACK (yylen);                                       \
-      yystate = *yyssp;                                         \
-      goto yybackup;                                            \
-    }                                                           \
-  else                                                          \
-    {                                                           \
-      yyerror (YY_("syntax error: cannot back up")); \
-      YYERROR;                                                  \
-    }                                                           \
-while (0)
-
-/* Error token number */
-#define YYTERROR        1
-#define YYERRCODE       256
-
-
-
-/* Enable debugging if requested.  */
-#if YYDEBUG
-
-# ifndef YYFPRINTF
-#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
-#  define YYFPRINTF fprintf
-# endif
-
-# define YYDPRINTF(Args)                        \
-do {                                            \
-  if (yydebug)                                  \
-    YYFPRINTF Args;                             \
-} while (0)
-
-/* This macro is provided for backward compatibility. */
-#ifndef YY_LOCATION_PRINT
-# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
-#endif
-
-
-# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
-do {                                                                      \
-  if (yydebug)                                                            \
-    {                                                                     \
-      YYFPRINTF (stderr, "%s ", Title);                                   \
-      yy_symbol_print (stderr,                                            \
-                  Type, Value); \
-      YYFPRINTF (stderr, "\n");                                           \
-    }                                                                     \
-} while (0)
-
-
-/*----------------------------------------.
-| Print this symbol's value on YYOUTPUT.  |
-`----------------------------------------*/
-
-static void
-yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
-{
-  FILE *yyo = yyoutput;
-  YYUSE (yyo);
-  if (!yyvaluep)
-    return;
-# ifdef YYPRINT
-  if (yytype < YYNTOKENS)
-    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
-# endif
-  YYUSE (yytype);
-}
-
-
-/*--------------------------------.
-| Print this symbol on YYOUTPUT.  |
-`--------------------------------*/
-
-static void
-yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
-{
-  YYFPRINTF (yyoutput, "%s %s (",
-             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);
-
-  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
-  YYFPRINTF (yyoutput, ")");
-}
-
-/*------------------------------------------------------------------.
-| yy_stack_print -- Print the state stack from its BOTTOM up to its |
-| TOP (included).                                                   |
-`------------------------------------------------------------------*/
-
-static void
-yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
-{
-  YYFPRINTF (stderr, "Stack now");
-  for (; yybottom <= yytop; yybottom++)
-    {
-      int yybot = *yybottom;
-      YYFPRINTF (stderr, " %d", yybot);
-    }
-  YYFPRINTF (stderr, "\n");
-}
-
-# define YY_STACK_PRINT(Bottom, Top)                            \
-do {                                                            \
-  if (yydebug)                                                  \
-    yy_stack_print ((Bottom), (Top));                           \
-} while (0)
-
-
-/*------------------------------------------------.
-| Report that the YYRULE is going to be reduced.  |
-`------------------------------------------------*/
-
-static void
-yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
-{
-  unsigned long int yylno = yyrline[yyrule];
-  int yynrhs = yyr2[yyrule];
-  int yyi;
-  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
-             yyrule - 1, yylno);
-  /* The symbols being reduced.  */
-  for (yyi = 0; yyi < yynrhs; yyi++)
-    {
-      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
-      yy_symbol_print (stderr,
-                       yystos[yyssp[yyi + 1 - yynrhs]],
-                       &(yyvsp[(yyi + 1) - (yynrhs)])
-                                              );
-      YYFPRINTF (stderr, "\n");
-    }
-}
-
-# define YY_REDUCE_PRINT(Rule)          \
-do {                                    \
-  if (yydebug)                          \
-    yy_reduce_print (yyssp, yyvsp, Rule); \
-} while (0)
-
-/* Nonzero means print parse trace.  It is left uninitialized so that
-   multiple parsers can coexist.  */
-int yydebug;
-#else /* !YYDEBUG */
-# define YYDPRINTF(Args)
-# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
-# define YY_STACK_PRINT(Bottom, Top)
-# define YY_REDUCE_PRINT(Rule)
-#endif /* !YYDEBUG */
-
-
-/* YYINITDEPTH -- initial size of the parser's stacks.  */
-#ifndef YYINITDEPTH
-# define YYINITDEPTH 200
-#endif
-
-/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
-   if the built-in stack extension method is used).
-
-   Do not make this value too large; the results are undefined if
-   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
-   evaluated with infinite-precision integer arithmetic.  */
-
-#ifndef YYMAXDEPTH
-# define YYMAXDEPTH 10000
-#endif
-
-
-#if YYERROR_VERBOSE
-
-# ifndef yystrlen
-#  if defined __GLIBC__ && defined _STRING_H
-#   define yystrlen strlen
-#  else
-/* Return the length of YYSTR.  */
-static YYSIZE_T
-yystrlen (const char *yystr)
-{
-  YYSIZE_T yylen;
-  for (yylen = 0; yystr[yylen]; yylen++)
-    continue;
-  return yylen;
-}
-#  endif
-# endif
-
-# ifndef yystpcpy
-#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
-#   define yystpcpy stpcpy
-#  else
-/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
-   YYDEST.  */
-static char *
-yystpcpy (char *yydest, const char *yysrc)
-{
-  char *yyd = yydest;
-  const char *yys = yysrc;
-
-  while ((*yyd++ = *yys++) != '\0')
-    continue;
-
-  return yyd - 1;
-}
-#  endif
-# endif
-
-# ifndef yytnamerr
-/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
-   quotes and backslashes, so that it's suitable for yyerror.  The
-   heuristic is that double-quoting is unnecessary unless the string
-   contains an apostrophe, a comma, or backslash (other than
-   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
-   null, do not copy; instead, return the length of what the result
-   would have been.  */
-static YYSIZE_T
-yytnamerr (char *yyres, const char *yystr)
-{
-  if (*yystr == '"')
-    {
-      YYSIZE_T yyn = 0;
-      char const *yyp = yystr;
-
-      for (;;)
-        switch (*++yyp)
-          {
-          case '\'':
-          case ',':
-            goto do_not_strip_quotes;
-
-          case '\\':
-            if (*++yyp != '\\')
-              goto do_not_strip_quotes;
-            /* Fall through.  */
-          default:
-            if (yyres)
-              yyres[yyn] = *yyp;
-            yyn++;
-            break;
-
-          case '"':
-            if (yyres)
-              yyres[yyn] = '\0';
-            return yyn;
-          }
-    do_not_strip_quotes: ;
-    }
-
-  if (! yyres)
-    return yystrlen (yystr);
-
-  return yystpcpy (yyres, yystr) - yyres;
-}
-# endif
-
-/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
-   about the unexpected token YYTOKEN for the state stack whose top is
-   YYSSP.
-
-   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
-   not large enough to hold the message.  In that case, also set
-   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
-   required number of bytes is too large to store.  */
-static int
-yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
-                yytype_int16 *yyssp, int yytoken)
-{
-  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
-  YYSIZE_T yysize = yysize0;
-  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
-  /* Internationalized format string. */
-  const char *yyformat = YY_NULLPTR;
-  /* Arguments of yyformat. */
-  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
-  /* Number of reported tokens (one for the "unexpected", one per
-     "expected"). */
-  int yycount = 0;
-
-  /* There are many possibilities here to consider:
-     - If this state is a consistent state with a default action, then
-       the only way this function was invoked is if the default action
-       is an error action.  In that case, don't check for expected
-       tokens because there are none.
-     - The only way there can be no lookahead present (in yychar) is if
-       this state is a consistent state with a default action.  Thus,
-       detecting the absence of a lookahead is sufficient to determine
-       that there is no unexpected or expected token to report.  In that
-       case, just report a simple "syntax error".
-     - Don't assume there isn't a lookahead just because this state is a
-       consistent state with a default action.  There might have been a
-       previous inconsistent state, consistent state with a non-default
-       action, or user semantic action that manipulated yychar.
-     - Of course, the expected token list depends on states to have
-       correct lookahead information, and it depends on the parser not
-       to perform extra reductions after fetching a lookahead from the
-       scanner and before detecting a syntax error.  Thus, state merging
-       (from LALR or IELR) and default reductions corrupt the expected
-       token list.  However, the list is correct for canonical LR with
-       one exception: it will still contain any token that will not be
-       accepted due to an error action in a later state.
-  */
-  if (yytoken != YYEMPTY)
-    {
-      int yyn = yypact[*yyssp];
-      yyarg[yycount++] = yytname[yytoken];
-      if (!yypact_value_is_default (yyn))
-        {
-          /* Start YYX at -YYN if negative to avoid negative indexes in
-             YYCHECK.  In other words, skip the first -YYN actions for
-             this state because they are default actions.  */
-          int yyxbegin = yyn < 0 ? -yyn : 0;
-          /* Stay within bounds of both yycheck and yytname.  */
-          int yychecklim = YYLAST - yyn + 1;
-          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
-          int yyx;
-
-          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
-            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
-                && !yytable_value_is_error (yytable[yyx + yyn]))
-              {
-                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
-                  {
-                    yycount = 1;
-                    yysize = yysize0;
-                    break;
-                  }
-                yyarg[yycount++] = yytname[yyx];
-                {
-                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
-                  if (! (yysize <= yysize1
-                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
-                    return 2;
-                  yysize = yysize1;
-                }
-              }
-        }
-    }
-
-  switch (yycount)
-    {
-# define YYCASE_(N, S)                      \
-      case N:                               \
-        yyformat = S;                       \
-      break
-      YYCASE_(0, YY_("syntax error"));
-      YYCASE_(1, YY_("syntax error, unexpected %s"));
-      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
-      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
-      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
-      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
-# undef YYCASE_
-    }
-
-  {
-    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
-    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
-      return 2;
-    yysize = yysize1;
-  }
-
-  if (*yymsg_alloc < yysize)
-    {
-      *yymsg_alloc = 2 * yysize;
-      if (! (yysize <= *yymsg_alloc
-             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
-        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
-      return 1;
-    }
-
-  /* Avoid sprintf, as that infringes on the user's name space.
-     Don't have undefined behavior even if the translation
-     produced a string with the wrong number of "%s"s.  */
-  {
-    char *yyp = *yymsg;
-    int yyi = 0;
-    while ((*yyp = *yyformat) != '\0')
-      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
-        {
-          yyp += yytnamerr (yyp, yyarg[yyi++]);
-          yyformat += 2;
-        }
-      else
-        {
-          yyp++;
-          yyformat++;
-        }
-  }
-  return 0;
-}
-#endif /* YYERROR_VERBOSE */
-
-/*-----------------------------------------------.
-| Release the memory associated to this symbol.  |
-`-----------------------------------------------*/
-
-static void
-yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
-{
-  YYUSE (yyvaluep);
-  if (!yymsg)
-    yymsg = "Deleting";
-  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);
-
-  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
-  switch (yytype)
-    {
-          case 58: /* choice_entry  */
-
-      {
-	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
-		((*yyvaluep).menu)->file->name, ((*yyvaluep).menu)->lineno);
-	if (current_menu == ((*yyvaluep).menu))
-		menu_end_menu();
-}
-
-        break;
-
-    case 64: /* if_entry  */
-
-      {
-	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
-		((*yyvaluep).menu)->file->name, ((*yyvaluep).menu)->lineno);
-	if (current_menu == ((*yyvaluep).menu))
-		menu_end_menu();
-}
-
-        break;
-
-    case 70: /* menu_entry  */
-
-      {
-	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
-		((*yyvaluep).menu)->file->name, ((*yyvaluep).menu)->lineno);
-	if (current_menu == ((*yyvaluep).menu))
-		menu_end_menu();
-}
-
-        break;
-
-
-      default:
-        break;
-    }
-  YY_IGNORE_MAYBE_UNINITIALIZED_END
-}
-
-
-
-
-/* The lookahead symbol.  */
-int yychar;
-
-/* The semantic value of the lookahead symbol.  */
-YYSTYPE yylval;
-/* Number of syntax errors so far.  */
-int yynerrs;
-
-
-/*----------.
-| yyparse.  |
-`----------*/
-
-int
-yyparse (void)
-{
-    int yystate;
-    /* Number of tokens to shift before error messages enabled.  */
-    int yyerrstatus;
-
-    /* The stacks and their tools:
-       'yyss': related to states.
-       'yyvs': related to semantic values.
-
-       Refer to the stacks through separate pointers, to allow yyoverflow
-       to reallocate them elsewhere.  */
-
-    /* The state stack.  */
-    yytype_int16 yyssa[YYINITDEPTH];
-    yytype_int16 *yyss;
-    yytype_int16 *yyssp;
-
-    /* The semantic value stack.  */
-    YYSTYPE yyvsa[YYINITDEPTH];
-    YYSTYPE *yyvs;
-    YYSTYPE *yyvsp;
-
-    YYSIZE_T yystacksize;
-
-  int yyn;
-  int yyresult;
-  /* Lookahead token as an internal (translated) token number.  */
-  int yytoken = 0;
-  /* The variables used to return semantic value and location from the
-     action routines.  */
-  YYSTYPE yyval;
-
-#if YYERROR_VERBOSE
-  /* Buffer for error messages, and its allocated size.  */
-  char yymsgbuf[128];
-  char *yymsg = yymsgbuf;
-  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
-#endif
-
-#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))
-
-  /* The number of symbols on the RHS of the reduced rule.
-     Keep to zero when no symbol should be popped.  */
-  int yylen = 0;
-
-  yyssp = yyss = yyssa;
-  yyvsp = yyvs = yyvsa;
-  yystacksize = YYINITDEPTH;
-
-  YYDPRINTF ((stderr, "Starting parse\n"));
-
-  yystate = 0;
-  yyerrstatus = 0;
-  yynerrs = 0;
-  yychar = YYEMPTY; /* Cause a token to be read.  */
-  goto yysetstate;
-
-/*------------------------------------------------------------.
-| yynewstate -- Push a new state, which is found in yystate.  |
-`------------------------------------------------------------*/
- yynewstate:
-  /* In all cases, when you get here, the value and location stacks
-     have just been pushed.  So pushing a state here evens the stacks.  */
-  yyssp++;
-
- yysetstate:
-  *yyssp = yystate;
-
-  if (yyss + yystacksize - 1 <= yyssp)
-    {
-      /* Get the current used size of the three stacks, in elements.  */
-      YYSIZE_T yysize = yyssp - yyss + 1;
-
-#ifdef yyoverflow
-      {
-        /* Give user a chance to reallocate the stack.  Use copies of
-           these so that the &'s don't force the real ones into
-           memory.  */
-        YYSTYPE *yyvs1 = yyvs;
-        yytype_int16 *yyss1 = yyss;
-
-        /* Each stack pointer address is followed by the size of the
-           data in use in that stack, in bytes.  This used to be a
-           conditional around just the two extra args, but that might
-           be undefined if yyoverflow is a macro.  */
-        yyoverflow (YY_("memory exhausted"),
-                    &yyss1, yysize * sizeof (*yyssp),
-                    &yyvs1, yysize * sizeof (*yyvsp),
-                    &yystacksize);
-
-        yyss = yyss1;
-        yyvs = yyvs1;
-      }
-#else /* no yyoverflow */
-# ifndef YYSTACK_RELOCATE
-      goto yyexhaustedlab;
-# else
-      /* Extend the stack our own way.  */
-      if (YYMAXDEPTH <= yystacksize)
-        goto yyexhaustedlab;
-      yystacksize *= 2;
-      if (YYMAXDEPTH < yystacksize)
-        yystacksize = YYMAXDEPTH;
-
-      {
-        yytype_int16 *yyss1 = yyss;
-        union yyalloc *yyptr =
-          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
-        if (! yyptr)
-          goto yyexhaustedlab;
-        YYSTACK_RELOCATE (yyss_alloc, yyss);
-        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
-#  undef YYSTACK_RELOCATE
-        if (yyss1 != yyssa)
-          YYSTACK_FREE (yyss1);
-      }
-# endif
-#endif /* no yyoverflow */
-
-      yyssp = yyss + yysize - 1;
-      yyvsp = yyvs + yysize - 1;
-
-      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
-                  (unsigned long int) yystacksize));
-
-      if (yyss + yystacksize - 1 <= yyssp)
-        YYABORT;
-    }
-
-  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
-
-  if (yystate == YYFINAL)
-    YYACCEPT;
-
-  goto yybackup;
-
-/*-----------.
-| yybackup.  |
-`-----------*/
-yybackup:
-
-  /* Do appropriate processing given the current state.  Read a
-     lookahead token if we need one and don't already have one.  */
-
-  /* First try to decide what to do without reference to lookahead token.  */
-  yyn = yypact[yystate];
-  if (yypact_value_is_default (yyn))
-    goto yydefault;
-
-  /* Not known => get a lookahead token if don't already have one.  */
-
-  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
-  if (yychar == YYEMPTY)
-    {
-      YYDPRINTF ((stderr, "Reading a token: "));
-      yychar = yylex ();
-    }
-
-  if (yychar <= YYEOF)
-    {
-      yychar = yytoken = YYEOF;
-      YYDPRINTF ((stderr, "Now at end of input.\n"));
-    }
-  else
-    {
-      yytoken = YYTRANSLATE (yychar);
-      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
-    }
-
-  /* If the proper action on seeing token YYTOKEN is to reduce or to
-     detect an error, take that action.  */
-  yyn += yytoken;
-  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
-    goto yydefault;
-  yyn = yytable[yyn];
-  if (yyn <= 0)
-    {
-      if (yytable_value_is_error (yyn))
-        goto yyerrlab;
-      yyn = -yyn;
-      goto yyreduce;
-    }
-
-  /* Count tokens shifted since error; after three, turn off error
-     status.  */
-  if (yyerrstatus)
-    yyerrstatus--;
-
-  /* Shift the lookahead token.  */
-  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
-
-  /* Discard the shifted token.  */
-  yychar = YYEMPTY;
-
-  yystate = yyn;
-  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
-  *++yyvsp = yylval;
-  YY_IGNORE_MAYBE_UNINITIALIZED_END
-
-  goto yynewstate;
-
-
-/*-----------------------------------------------------------.
-| yydefault -- do the default action for the current state.  |
-`-----------------------------------------------------------*/
-yydefault:
-  yyn = yydefact[yystate];
-  if (yyn == 0)
-    goto yyerrlab;
-  goto yyreduce;
-
-
-/*-----------------------------.
-| yyreduce -- Do a reduction.  |
-`-----------------------------*/
-yyreduce:
-  /* yyn is the number of a rule to reduce with.  */
-  yylen = yyr2[yyn];
-
-  /* If YYLEN is nonzero, implement the default value of the action:
-     '$$ = $1'.
-
-     Otherwise, the following line sets YYVAL to garbage.
-     This behavior is undocumented and Bison
-     users should not rely upon it.  Assigning to YYVAL
-     unconditionally makes the parser a bit smaller, and it avoids a
-     GCC warning that YYVAL may be used uninitialized.  */
-  yyval = yyvsp[1-yylen];
-
-
-  YY_REDUCE_PRINT (yyn);
-  switch (yyn)
-    {
-        case 10:
-
-    { zconf_error("unexpected end statement"); }
-
-    break;
-
-  case 11:
-
-    { zconf_error("unknown statement \"%s\"", (yyvsp[-2].string)); }
-
-    break;
-
-  case 12:
-
-    {
-	zconf_error("unexpected option \"%s\"", kconf_id_strings + (yyvsp[-2].id)->name);
-}
-
-    break;
-
-  case 13:
-
-    { zconf_error("invalid statement"); }
-
-    break;
-
-  case 29:
-
-    { zconf_error("unknown option \"%s\"", (yyvsp[-2].string)); }
-
-    break;
-
-  case 30:
-
-    { zconf_error("invalid option"); }
-
-    break;
-
-  case 31:
-
-    {
-	struct symbol *sym = sym_lookup((yyvsp[-1].string), 0);
-	sym->flags |= SYMBOL_OPTIONAL;
-	menu_add_entry(sym);
-	printd(DEBUG_PARSE, "%s:%d:config %s\n", zconf_curname(), zconf_lineno(), (yyvsp[-1].string));
-}
-
-    break;
-
-  case 32:
-
-    {
-	menu_end_entry();
-	printd(DEBUG_PARSE, "%s:%d:endconfig\n", zconf_curname(), zconf_lineno());
-}
-
-    break;
-
-  case 33:
-
-    {
-	struct symbol *sym = sym_lookup((yyvsp[-1].string), 0);
-	sym->flags |= SYMBOL_OPTIONAL;
-	menu_add_entry(sym);
-	printd(DEBUG_PARSE, "%s:%d:menuconfig %s\n", zconf_curname(), zconf_lineno(), (yyvsp[-1].string));
-}
-
-    break;
-
-  case 34:
-
-    {
-	if (current_entry->prompt)
-		current_entry->prompt->type = P_MENU;
-	else
-		zconfprint("warning: menuconfig statement without prompt");
-	menu_end_entry();
-	printd(DEBUG_PARSE, "%s:%d:endconfig\n", zconf_curname(), zconf_lineno());
-}
-
-    break;
-
-  case 42:
-
-    {
-	menu_set_type((yyvsp[-2].id)->stype);
-	printd(DEBUG_PARSE, "%s:%d:type(%u)\n",
-		zconf_curname(), zconf_lineno(),
-		(yyvsp[-2].id)->stype);
-}
-
-    break;
-
-  case 43:
-
-    {
-	menu_add_prompt(P_PROMPT, (yyvsp[-2].string), (yyvsp[-1].expr));
-	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
-}
-
-    break;
-
-  case 44:
-
-    {
-	menu_add_expr(P_DEFAULT, (yyvsp[-2].expr), (yyvsp[-1].expr));
-	if ((yyvsp[-3].id)->stype != S_UNKNOWN)
-		menu_set_type((yyvsp[-3].id)->stype);
-	printd(DEBUG_PARSE, "%s:%d:default(%u)\n",
-		zconf_curname(), zconf_lineno(),
-		(yyvsp[-3].id)->stype);
-}
-
-    break;
-
-  case 45:
-
-    {
-	menu_add_symbol(P_SELECT, sym_lookup((yyvsp[-2].string), 0), (yyvsp[-1].expr));
-	printd(DEBUG_PARSE, "%s:%d:select\n", zconf_curname(), zconf_lineno());
-}
-
-    break;
-
-  case 46:
-
-    {
-	menu_add_symbol(P_IMPLY, sym_lookup((yyvsp[-2].string), 0), (yyvsp[-1].expr));
-	printd(DEBUG_PARSE, "%s:%d:imply\n", zconf_curname(), zconf_lineno());
-}
-
-    break;
-
-  case 47:
-
-    {
-	menu_add_expr(P_RANGE, expr_alloc_comp(E_RANGE,(yyvsp[-3].symbol), (yyvsp[-2].symbol)), (yyvsp[-1].expr));
-	printd(DEBUG_PARSE, "%s:%d:range\n", zconf_curname(), zconf_lineno());
-}
-
-    break;
-
-  case 50:
-
-    {
-	const struct kconf_id *id = kconf_id_lookup((yyvsp[-1].string), strlen((yyvsp[-1].string)));
-	if (id && id->flags & TF_OPTION)
-		menu_add_option(id->token, (yyvsp[0].string));
-	else
-		zconfprint("warning: ignoring unknown option %s", (yyvsp[-1].string));
-	free((yyvsp[-1].string));
-}
-
-    break;
-
-  case 51:
-
-    { (yyval.string) = NULL; }
-
-    break;
-
-  case 52:
-
-    { (yyval.string) = (yyvsp[0].string); }
-
-    break;
-
-  case 53:
-
-    {
-	struct symbol *sym = sym_lookup((yyvsp[-1].string), SYMBOL_CHOICE);
-	sym->flags |= SYMBOL_AUTO;
-	menu_add_entry(sym);
-	menu_add_expr(P_CHOICE, NULL, NULL);
-	printd(DEBUG_PARSE, "%s:%d:choice\n", zconf_curname(), zconf_lineno());
-}
-
-    break;
-
-  case 54:
-
-    {
-	(yyval.menu) = menu_add_menu();
-}
-
-    break;
-
-  case 55:
-
-    {
-	if (zconf_endtoken((yyvsp[0].id), T_CHOICE, T_ENDCHOICE)) {
-		menu_end_menu();
-		printd(DEBUG_PARSE, "%s:%d:endchoice\n", zconf_curname(), zconf_lineno());
-	}
-}
-
-    break;
-
-  case 63:
-
-    {
-	menu_add_prompt(P_PROMPT, (yyvsp[-2].string), (yyvsp[-1].expr));
-	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
-}
-
-    break;
-
-  case 64:
-
-    {
-	if ((yyvsp[-2].id)->stype == S_BOOLEAN || (yyvsp[-2].id)->stype == S_TRISTATE) {
-		menu_set_type((yyvsp[-2].id)->stype);
-		printd(DEBUG_PARSE, "%s:%d:type(%u)\n",
-			zconf_curname(), zconf_lineno(),
-			(yyvsp[-2].id)->stype);
-	} else
-		YYERROR;
-}
-
-    break;
-
-  case 65:
-
-    {
-	current_entry->sym->flags |= SYMBOL_OPTIONAL;
-	printd(DEBUG_PARSE, "%s:%d:optional\n", zconf_curname(), zconf_lineno());
-}
-
-    break;
-
-  case 66:
-
-    {
-	if ((yyvsp[-3].id)->stype == S_UNKNOWN) {
-		menu_add_symbol(P_DEFAULT, sym_lookup((yyvsp[-2].string), 0), (yyvsp[-1].expr));
-		printd(DEBUG_PARSE, "%s:%d:default\n",
-			zconf_curname(), zconf_lineno());
-	} else
-		YYERROR;
-}
-
-    break;
-
-  case 69:
-
-    {
-	printd(DEBUG_PARSE, "%s:%d:if\n", zconf_curname(), zconf_lineno());
-	menu_add_entry(NULL);
-	menu_add_dep((yyvsp[-1].expr));
-	(yyval.menu) = menu_add_menu();
-}
-
-    break;
-
-  case 70:
-
-    {
-	if (zconf_endtoken((yyvsp[0].id), T_IF, T_ENDIF)) {
-		menu_end_menu();
-		printd(DEBUG_PARSE, "%s:%d:endif\n", zconf_curname(), zconf_lineno());
-	}
-}
-
-    break;
-
-  case 76:
-
-    {
-	menu_add_prompt(P_MENU, (yyvsp[-1].string), NULL);
-}
-
-    break;
-
-  case 77:
-
-    {
-	menu_add_entry(NULL);
-	menu_add_prompt(P_MENU, (yyvsp[-1].string), NULL);
-	printd(DEBUG_PARSE, "%s:%d:menu\n", zconf_curname(), zconf_lineno());
-}
-
-    break;
-
-  case 78:
-
-    {
-	(yyval.menu) = menu_add_menu();
-}
-
-    break;
-
-  case 79:
-
-    {
-	if (zconf_endtoken((yyvsp[0].id), T_MENU, T_ENDMENU)) {
-		menu_end_menu();
-		printd(DEBUG_PARSE, "%s:%d:endmenu\n", zconf_curname(), zconf_lineno());
-	}
-}
-
-    break;
-
-  case 85:
-
-    {
-	printd(DEBUG_PARSE, "%s:%d:source %s\n", zconf_curname(), zconf_lineno(), (yyvsp[-1].string));
-	zconf_nextfile((yyvsp[-1].string));
-}
-
-    break;
-
-  case 86:
-
-    {
-	menu_add_entry(NULL);
-	menu_add_prompt(P_COMMENT, (yyvsp[-1].string), NULL);
-	printd(DEBUG_PARSE, "%s:%d:comment\n", zconf_curname(), zconf_lineno());
-}
-
-    break;
-
-  case 87:
-
-    {
-	menu_end_entry();
-}
-
-    break;
-
-  case 88:
-
-    {
-	printd(DEBUG_PARSE, "%s:%d:help\n", zconf_curname(), zconf_lineno());
-	zconf_starthelp();
-}
-
-    break;
-
-  case 89:
-
-    {
-	current_entry->help = (yyvsp[0].string);
-}
-
-    break;
-
-  case 94:
-
-    {
-	menu_add_dep((yyvsp[-1].expr));
-	printd(DEBUG_PARSE, "%s:%d:depends on\n", zconf_curname(), zconf_lineno());
-}
-
-    break;
-
-  case 98:
-
-    {
-	menu_add_visibility((yyvsp[0].expr));
-}
-
-    break;
-
-  case 100:
-
-    {
-	menu_add_prompt(P_PROMPT, (yyvsp[-1].string), (yyvsp[0].expr));
-}
-
-    break;
-
-  case 103:
-
-    { (yyval.id) = (yyvsp[-1].id); }
-
-    break;
-
-  case 104:
-
-    { (yyval.id) = (yyvsp[-1].id); }
-
-    break;
-
-  case 105:
-
-    { (yyval.id) = (yyvsp[-1].id); }
-
-    break;
-
-  case 108:
-
-    { (yyval.expr) = NULL; }
-
-    break;
-
-  case 109:
-
-    { (yyval.expr) = (yyvsp[0].expr); }
-
-    break;
-
-  case 110:
-
-    { (yyval.expr) = expr_alloc_symbol((yyvsp[0].symbol)); }
-
-    break;
-
-  case 111:
-
-    { (yyval.expr) = expr_alloc_comp(E_LTH, (yyvsp[-2].symbol), (yyvsp[0].symbol)); }
-
-    break;
-
-  case 112:
-
-    { (yyval.expr) = expr_alloc_comp(E_LEQ, (yyvsp[-2].symbol), (yyvsp[0].symbol)); }
-
-    break;
-
-  case 113:
-
-    { (yyval.expr) = expr_alloc_comp(E_GTH, (yyvsp[-2].symbol), (yyvsp[0].symbol)); }
-
-    break;
-
-  case 114:
-
-    { (yyval.expr) = expr_alloc_comp(E_GEQ, (yyvsp[-2].symbol), (yyvsp[0].symbol)); }
-
-    break;
-
-  case 115:
-
-    { (yyval.expr) = expr_alloc_comp(E_EQUAL, (yyvsp[-2].symbol), (yyvsp[0].symbol)); }
-
-    break;
-
-  case 116:
-
-    { (yyval.expr) = expr_alloc_comp(E_UNEQUAL, (yyvsp[-2].symbol), (yyvsp[0].symbol)); }
-
-    break;
-
-  case 117:
-
-    { (yyval.expr) = (yyvsp[-1].expr); }
-
-    break;
-
-  case 118:
-
-    { (yyval.expr) = expr_alloc_one(E_NOT, (yyvsp[0].expr)); }
-
-    break;
-
-  case 119:
-
-    { (yyval.expr) = expr_alloc_two(E_OR, (yyvsp[-2].expr), (yyvsp[0].expr)); }
-
-    break;
-
-  case 120:
-
-    { (yyval.expr) = expr_alloc_two(E_AND, (yyvsp[-2].expr), (yyvsp[0].expr)); }
-
-    break;
-
-  case 121:
-
-    { (yyval.symbol) = sym_lookup((yyvsp[0].string), 0); free((yyvsp[0].string)); }
-
-    break;
-
-  case 122:
-
-    { (yyval.symbol) = sym_lookup((yyvsp[0].string), SYMBOL_CONST); free((yyvsp[0].string)); }
-
-    break;
-
-  case 123:
-
-    { (yyval.string) = NULL; }
-
-    break;
-
-
-
-      default: break;
-    }
-  /* User semantic actions sometimes alter yychar, and that requires
-     that yytoken be updated with the new translation.  We take the
-     approach of translating immediately before every use of yytoken.
-     One alternative is translating here after every semantic action,
-     but that translation would be missed if the semantic action invokes
-     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
-     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
-     incorrect destructor might then be invoked immediately.  In the
-     case of YYERROR or YYBACKUP, subsequent parser actions might lead
-     to an incorrect destructor call or verbose syntax error message
-     before the lookahead is translated.  */
-  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);
-
-  YYPOPSTACK (yylen);
-  yylen = 0;
-  YY_STACK_PRINT (yyss, yyssp);
-
-  *++yyvsp = yyval;
-
-  /* Now 'shift' the result of the reduction.  Determine what state
-     that goes to, based on the state we popped back to and the rule
-     number reduced by.  */
-
-  yyn = yyr1[yyn];
-
-  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
-  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
-    yystate = yytable[yystate];
-  else
-    yystate = yydefgoto[yyn - YYNTOKENS];
-
-  goto yynewstate;
-
-
-/*--------------------------------------.
-| yyerrlab -- here on detecting error.  |
-`--------------------------------------*/
-yyerrlab:
-  /* Make sure we have latest lookahead translation.  See comments at
-     user semantic actions for why this is necessary.  */
-  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);
-
-  /* If not already recovering from an error, report this error.  */
-  if (!yyerrstatus)
-    {
-      ++yynerrs;
-#if ! YYERROR_VERBOSE
-      yyerror (YY_("syntax error"));
-#else
-# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
-                                        yyssp, yytoken)
-      {
-        char const *yymsgp = YY_("syntax error");
-        int yysyntax_error_status;
-        yysyntax_error_status = YYSYNTAX_ERROR;
-        if (yysyntax_error_status == 0)
-          yymsgp = yymsg;
-        else if (yysyntax_error_status == 1)
-          {
-            if (yymsg != yymsgbuf)
-              YYSTACK_FREE (yymsg);
-            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
-            if (!yymsg)
-              {
-                yymsg = yymsgbuf;
-                yymsg_alloc = sizeof yymsgbuf;
-                yysyntax_error_status = 2;
-              }
-            else
-              {
-                yysyntax_error_status = YYSYNTAX_ERROR;
-                yymsgp = yymsg;
-              }
-          }
-        yyerror (yymsgp);
-        if (yysyntax_error_status == 2)
-          goto yyexhaustedlab;
-      }
-# undef YYSYNTAX_ERROR
-#endif
-    }
-
-
-
-  if (yyerrstatus == 3)
-    {
-      /* If just tried and failed to reuse lookahead token after an
-         error, discard it.  */
-
-      if (yychar <= YYEOF)
-        {
-          /* Return failure if at end of input.  */
-          if (yychar == YYEOF)
-            YYABORT;
-        }
-      else
-        {
-          yydestruct ("Error: discarding",
-                      yytoken, &yylval);
-          yychar = YYEMPTY;
-        }
-    }
-
-  /* Else will try to reuse lookahead token after shifting the error
-     token.  */
-  goto yyerrlab1;
-
-
-/*---------------------------------------------------.
-| yyerrorlab -- error raised explicitly by YYERROR.  |
-`---------------------------------------------------*/
-yyerrorlab:
-
-  /* Pacify compilers like GCC when the user code never invokes
-     YYERROR and the label yyerrorlab therefore never appears in user
-     code.  */
-  if (/*CONSTCOND*/ 0)
-     goto yyerrorlab;
-
-  /* Do not reclaim the symbols of the rule whose action triggered
-     this YYERROR.  */
-  YYPOPSTACK (yylen);
-  yylen = 0;
-  YY_STACK_PRINT (yyss, yyssp);
-  yystate = *yyssp;
-  goto yyerrlab1;
-
-
-/*-------------------------------------------------------------.
-| yyerrlab1 -- common code for both syntax error and YYERROR.  |
-`-------------------------------------------------------------*/
-yyerrlab1:
-  yyerrstatus = 3;      /* Each real token shifted decrements this.  */
-
-  for (;;)
-    {
-      yyn = yypact[yystate];
-      if (!yypact_value_is_default (yyn))
-        {
-          yyn += YYTERROR;
-          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
-            {
-              yyn = yytable[yyn];
-              if (0 < yyn)
-                break;
-            }
-        }
-
-      /* Pop the current state because it cannot handle the error token.  */
-      if (yyssp == yyss)
-        YYABORT;
-
-
-      yydestruct ("Error: popping",
-                  yystos[yystate], yyvsp);
-      YYPOPSTACK (1);
-      yystate = *yyssp;
-      YY_STACK_PRINT (yyss, yyssp);
-    }
-
-  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
-  *++yyvsp = yylval;
-  YY_IGNORE_MAYBE_UNINITIALIZED_END
-
-
-  /* Shift the error token.  */
-  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);
-
-  yystate = yyn;
-  goto yynewstate;
-
-
-/*-------------------------------------.
-| yyacceptlab -- YYACCEPT comes here.  |
-`-------------------------------------*/
-yyacceptlab:
-  yyresult = 0;
-  goto yyreturn;
-
-/*-----------------------------------.
-| yyabortlab -- YYABORT comes here.  |
-`-----------------------------------*/
-yyabortlab:
-  yyresult = 1;
-  goto yyreturn;
-
-#if !defined yyoverflow || YYERROR_VERBOSE
-/*-------------------------------------------------.
-| yyexhaustedlab -- memory exhaustion comes here.  |
-`-------------------------------------------------*/
-yyexhaustedlab:
-  yyerror (YY_("memory exhausted"));
-  yyresult = 2;
-  /* Fall through.  */
-#endif
-
-yyreturn:
-  if (yychar != YYEMPTY)
-    {
-      /* Make sure we have latest lookahead translation.  See comments at
-         user semantic actions for why this is necessary.  */
-      yytoken = YYTRANSLATE (yychar);
-      yydestruct ("Cleanup: discarding lookahead",
-                  yytoken, &yylval);
-    }
-  /* Do not reclaim the symbols of the rule whose action triggered
-     this YYABORT or YYACCEPT.  */
-  YYPOPSTACK (yylen);
-  YY_STACK_PRINT (yyss, yyssp);
-  while (yyssp != yyss)
-    {
-      yydestruct ("Cleanup: popping",
-                  yystos[*yyssp], yyvsp);
-      YYPOPSTACK (1);
-    }
-#ifndef yyoverflow
-  if (yyss != yyssa)
-    YYSTACK_FREE (yyss);
-#endif
-#if YYERROR_VERBOSE
-  if (yymsg != yymsgbuf)
-    YYSTACK_FREE (yymsg);
-#endif
-  return yyresult;
-}
-
-
-
-void conf_parse(const char *name)
-{
-	struct symbol *sym;
-	int i;
-
-	zconf_initscan(name);
-
-	sym_init();
-	_menu_init();
-	rootmenu.prompt = menu_add_prompt(P_MENU, "Linux Kernel Configuration", NULL);
-
-	if (getenv("ZCONF_DEBUG"))
-		zconfdebug = 1;
-	zconfparse();
-	if (zconfnerrs)
-		exit(1);
-	if (!modules_sym)
-		modules_sym = sym_find( "n" );
-
-	rootmenu.prompt->text = _(rootmenu.prompt->text);
-	rootmenu.prompt->text = sym_expand_string_value(rootmenu.prompt->text);
-
-	menu_finalize(&rootmenu);
-	for_all_symbols(i, sym) {
-		if (sym_check_deps(sym))
-			zconfnerrs++;
-	}
-	if (zconfnerrs)
-		exit(1);
-	sym_set_change_count(1);
-}
-
-static const char *zconf_tokenname(int token)
-{
-	switch (token) {
-	case T_MENU:		return "menu";
-	case T_ENDMENU:		return "endmenu";
-	case T_CHOICE:		return "choice";
-	case T_ENDCHOICE:	return "endchoice";
-	case T_IF:		return "if";
-	case T_ENDIF:		return "endif";
-	case T_DEPENDS:		return "depends";
-	case T_VISIBLE:		return "visible";
-	}
-	return "<token>";
-}
-
-static bool zconf_endtoken(const struct kconf_id *id, int starttoken, int endtoken)
-{
-	if (id->token != endtoken) {
-		zconf_error("unexpected '%s' within %s block",
-			kconf_id_strings + id->name, zconf_tokenname(starttoken));
-		zconfnerrs++;
-		return false;
-	}
-	if (current_menu->file != current_file) {
-		zconf_error("'%s' in different file than '%s'",
-			kconf_id_strings + id->name, zconf_tokenname(starttoken));
-		fprintf(stderr, "%s:%d: location of the '%s'\n",
-			current_menu->file->name, current_menu->lineno,
-			zconf_tokenname(starttoken));
-		zconfnerrs++;
-		return false;
-	}
-	return true;
-}
-
-static void zconfprint(const char *err, ...)
-{
-	va_list ap;
-
-	fprintf(stderr, "%s:%d: ", zconf_curname(), zconf_lineno());
-	va_start(ap, err);
-	vfprintf(stderr, err, ap);
-	va_end(ap);
-	fprintf(stderr, "\n");
-}
-
-static void zconf_error(const char *err, ...)
-{
-	va_list ap;
-
-	zconfnerrs++;
-	fprintf(stderr, "%s:%d: ", zconf_curname(), zconf_lineno());
-	va_start(ap, err);
-	vfprintf(stderr, err, ap);
-	va_end(ap);
-	fprintf(stderr, "\n");
-}
-
-static void zconferror(const char *err)
-{
-	fprintf(stderr, "%s:%d: %s\n", zconf_curname(), zconf_lineno() + 1, err);
-}
-
-static void print_quoted_string(FILE *out, const char *str)
-{
-	const char *p;
-	int len;
-
-	putc('"', out);
-	while ((p = strchr(str, '"'))) {
-		len = p - str;
-		if (len)
-			fprintf(out, "%.*s", len, str);
-		fputs("\\\"", out);
-		str = p + 1;
-	}
-	fputs(str, out);
-	putc('"', out);
-}
-
-static void print_symbol(FILE *out, struct menu *menu)
-{
-	struct symbol *sym = menu->sym;
-	struct property *prop;
-
-	if (sym_is_choice(sym))
-		fprintf(out, "\nchoice\n");
-	else
-		fprintf(out, "\nconfig %s\n", sym->name);
-	switch (sym->type) {
-	case S_BOOLEAN:
-		fputs("  boolean\n", out);
-		break;
-	case S_TRISTATE:
-		fputs("  tristate\n", out);
-		break;
-	case S_STRING:
-		fputs("  string\n", out);
-		break;
-	case S_INT:
-		fputs("  integer\n", out);
-		break;
-	case S_HEX:
-		fputs("  hex\n", out);
-		break;
-	default:
-		fputs("  ???\n", out);
-		break;
-	}
-	for (prop = sym->prop; prop; prop = prop->next) {
-		if (prop->menu != menu)
-			continue;
-		switch (prop->type) {
-		case P_PROMPT:
-			fputs("  prompt ", out);
-			print_quoted_string(out, prop->text);
-			if (!expr_is_yes(prop->visible.expr)) {
-				fputs(" if ", out);
-				expr_fprint(prop->visible.expr, out);
-			}
-			fputc('\n', out);
-			break;
-		case P_DEFAULT:
-			fputs( "  default ", out);
-			expr_fprint(prop->expr, out);
-			if (!expr_is_yes(prop->visible.expr)) {
-				fputs(" if ", out);
-				expr_fprint(prop->visible.expr, out);
-			}
-			fputc('\n', out);
-			break;
-		case P_CHOICE:
-			fputs("  #choice value\n", out);
-			break;
-		case P_SELECT:
-			fputs( "  select ", out);
-			expr_fprint(prop->expr, out);
-			fputc('\n', out);
-			break;
-		case P_IMPLY:
-			fputs( "  imply ", out);
-			expr_fprint(prop->expr, out);
-			fputc('\n', out);
-			break;
-		case P_RANGE:
-			fputs( "  range ", out);
-			expr_fprint(prop->expr, out);
-			fputc('\n', out);
-			break;
-		case P_MENU:
-			fputs( "  menu ", out);
-			print_quoted_string(out, prop->text);
-			fputc('\n', out);
-			break;
-		default:
-			fprintf(out, "  unknown prop %d!\n", prop->type);
-			break;
-		}
-	}
-	if (menu->help) {
-		int len = strlen(menu->help);
-		while (menu->help[--len] == '\n')
-			menu->help[len] = 0;
-		fprintf(out, "  help\n%s\n", menu->help);
-	}
-}
-
-void zconfdump(FILE *out)
-{
-	struct property *prop;
-	struct symbol *sym;
-	struct menu *menu;
-
-	menu = rootmenu.list;
-	while (menu) {
-		if ((sym = menu->sym))
-			print_symbol(out, menu);
-		else if ((prop = menu->prompt)) {
-			switch (prop->type) {
-			case P_COMMENT:
-				fputs("\ncomment ", out);
-				print_quoted_string(out, prop->text);
-				fputs("\n", out);
-				break;
-			case P_MENU:
-				fputs("\nmenu ", out);
-				print_quoted_string(out, prop->text);
-				fputs("\n", out);
-				break;
-			default:
-				;
-			}
-			if (!expr_is_yes(prop->visible.expr)) {
-				fputs("  depends ", out);
-				expr_fprint(prop->visible.expr, out);
-				fputc('\n', out);
-			}
-		}
-
-		if (menu->list)
-			menu = menu->list;
-		else if (menu->next)
-			menu = menu->next;
-		else while ((menu = menu->parent)) {
-			if (menu->prompt && menu->prompt->type == P_MENU)
-				fputs("\nendmenu\n", out);
-			if (menu->next) {
-				menu = menu->next;
-				break;
-			}
-		}
-	}
-}
-
-#include "zconf.lex.c"
-#include "util.c"
-#include "confdata.c"
-#include "expr.c"
-#include "symbol.c"
-#include "menu.c"
diff --git a/backport/kconf/zconf.y b/backport/kconf/zconf.y
new file mode 100644
index 00000000..ad6305b0
--- /dev/null
+++ b/backport/kconf/zconf.y
@@ -0,0 +1,782 @@
+%{
+/*
+ * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
+ * Released under the terms of the GNU GPL v2.0.
+ */
+
+#include <ctype.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+
+#include "lkc.h"
+
+#define printd(mask, fmt...) if (cdebug & (mask)) printf(fmt)
+
+#define PRINTD		0x0001
+#define DEBUG_PARSE	0x0002
+
+int cdebug = PRINTD;
+
+int yylex(void);
+static void yyerror(const char *err);
+static void zconfprint(const char *err, ...);
+static void zconf_error(const char *err, ...);
+static bool zconf_endtoken(const struct kconf_id *id, int starttoken, int endtoken);
+
+struct symbol *symbol_hash[SYMBOL_HASHSIZE];
+
+static struct menu *current_menu, *current_entry;
+
+%}
+%expect 32
+
+%union
+{
+	char *string;
+	struct file *file;
+	struct symbol *symbol;
+	struct expr *expr;
+	struct menu *menu;
+	const struct kconf_id *id;
+}
+
+%token <id>T_MAINMENU
+%token <id>T_MENU
+%token <id>T_ENDMENU
+%token <id>T_SOURCE
+%token <id>T_CHOICE
+%token <id>T_ENDCHOICE
+%token <id>T_COMMENT
+%token <id>T_CONFIG
+%token <id>T_MENUCONFIG
+%token <id>T_HELP
+%token <string> T_HELPTEXT
+%token <id>T_IF
+%token <id>T_ENDIF
+%token <id>T_DEPENDS
+%token <id>T_OPTIONAL
+%token <id>T_PROMPT
+%token <id>T_TYPE
+%token <id>T_DEFAULT
+%token <id>T_SELECT
+%token <id>T_IMPLY
+%token <id>T_RANGE
+%token <id>T_VISIBLE
+%token <id>T_OPTION
+%token <id>T_ON
+%token <string> T_WORD
+%token <string> T_WORD_QUOTE
+%token T_UNEQUAL
+%token T_LESS
+%token T_LESS_EQUAL
+%token T_GREATER
+%token T_GREATER_EQUAL
+%token T_CLOSE_PAREN
+%token T_OPEN_PAREN
+%token T_EOL
+
+%left T_OR
+%left T_AND
+%left T_EQUAL T_UNEQUAL
+%left T_LESS T_LESS_EQUAL T_GREATER T_GREATER_EQUAL
+%nonassoc T_NOT
+
+%type <string> prompt
+%type <symbol> nonconst_symbol
+%type <symbol> symbol
+%type <expr> expr
+%type <expr> if_expr
+%type <id> end
+%type <id> option_name
+%type <menu> if_entry menu_entry choice_entry
+%type <string> symbol_option_arg word_opt
+
+%destructor {
+	fprintf(stderr, "%s:%d: missing end statement for this entry\n",
+		$$->file->name, $$->lineno);
+	if (current_menu == $$)
+		menu_end_menu();
+} if_entry menu_entry choice_entry
+
+%{
+/* Include kconf_id.c here so it can see the token constants. */
+#include "kconf_id.c"
+%}
+
+%%
+input: nl start | start;
+
+start: mainmenu_stmt stmt_list | no_mainmenu_stmt stmt_list;
+
+/* mainmenu entry */
+
+mainmenu_stmt: T_MAINMENU prompt nl
+{
+	menu_add_prompt(P_MENU, $2, NULL);
+};
+
+/* Default main menu, if there's no mainmenu entry */
+
+no_mainmenu_stmt: /* empty */
+{
+	/*
+	 * Hack: Keep the main menu title on the heap so we can safely free it
+	 * later regardless of whether it comes from the 'prompt' in
+	 * mainmenu_stmt or here
+	 */
+	menu_add_prompt(P_MENU, xstrdup("Linux Kernel Configuration"), NULL);
+};
+
+
+stmt_list:
+	  /* empty */
+	| stmt_list common_stmt
+	| stmt_list choice_stmt
+	| stmt_list menu_stmt
+	| stmt_list end			{ zconf_error("unexpected end statement"); }
+	| stmt_list T_WORD error T_EOL	{ zconf_error("unknown statement \"%s\"", $2); }
+	| stmt_list option_name error T_EOL
+{
+	zconf_error("unexpected option \"%s\"", $2->name);
+}
+	| stmt_list error T_EOL		{ zconf_error("invalid statement"); }
+;
+
+option_name:
+	T_DEPENDS | T_PROMPT | T_TYPE | T_SELECT | T_IMPLY | T_OPTIONAL | T_RANGE | T_DEFAULT | T_VISIBLE
+;
+
+common_stmt:
+	  T_EOL
+	| if_stmt
+	| comment_stmt
+	| config_stmt
+	| menuconfig_stmt
+	| source_stmt
+;
+
+option_error:
+	  T_WORD error T_EOL		{ zconf_error("unknown option \"%s\"", $1); }
+	| error T_EOL			{ zconf_error("invalid option"); }
+;
+
+
+/* config/menuconfig entry */
+
+config_entry_start: T_CONFIG nonconst_symbol T_EOL
+{
+	$2->flags |= SYMBOL_OPTIONAL;
+	menu_add_entry($2);
+	printd(DEBUG_PARSE, "%s:%d:config %s\n", zconf_curname(), zconf_lineno(), $2->name);
+};
+
+config_stmt: config_entry_start config_option_list
+{
+	printd(DEBUG_PARSE, "%s:%d:endconfig\n", zconf_curname(), zconf_lineno());
+};
+
+menuconfig_entry_start: T_MENUCONFIG nonconst_symbol T_EOL
+{
+	$2->flags |= SYMBOL_OPTIONAL;
+	menu_add_entry($2);
+	printd(DEBUG_PARSE, "%s:%d:menuconfig %s\n", zconf_curname(), zconf_lineno(), $2->name);
+};
+
+menuconfig_stmt: menuconfig_entry_start config_option_list
+{
+	if (current_entry->prompt)
+		current_entry->prompt->type = P_MENU;
+	else
+		zconfprint("warning: menuconfig statement without prompt");
+	printd(DEBUG_PARSE, "%s:%d:endconfig\n", zconf_curname(), zconf_lineno());
+};
+
+config_option_list:
+	  /* empty */
+	| config_option_list config_option
+	| config_option_list symbol_option
+	| config_option_list depends
+	| config_option_list help
+	| config_option_list option_error
+	| config_option_list T_EOL
+;
+
+config_option: T_TYPE prompt_stmt_opt T_EOL
+{
+	menu_set_type($1->stype);
+	printd(DEBUG_PARSE, "%s:%d:type(%u)\n",
+		zconf_curname(), zconf_lineno(),
+		$1->stype);
+};
+
+config_option: T_PROMPT prompt if_expr T_EOL
+{
+	menu_add_prompt(P_PROMPT, $2, $3);
+	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
+};
+
+config_option: T_DEFAULT expr if_expr T_EOL
+{
+	menu_add_expr(P_DEFAULT, $2, $3);
+	if ($1->stype != S_UNKNOWN)
+		menu_set_type($1->stype);
+	printd(DEBUG_PARSE, "%s:%d:default(%u)\n",
+		zconf_curname(), zconf_lineno(),
+		$1->stype);
+};
+
+config_option: T_SELECT nonconst_symbol if_expr T_EOL
+{
+	menu_add_symbol(P_SELECT, $2, $3);
+	printd(DEBUG_PARSE, "%s:%d:select\n", zconf_curname(), zconf_lineno());
+};
+
+config_option: T_IMPLY nonconst_symbol if_expr T_EOL
+{
+	menu_add_symbol(P_IMPLY, $2, $3);
+	printd(DEBUG_PARSE, "%s:%d:imply\n", zconf_curname(), zconf_lineno());
+};
+
+config_option: T_RANGE symbol symbol if_expr T_EOL
+{
+	menu_add_expr(P_RANGE, expr_alloc_comp(E_RANGE,$2, $3), $4);
+	printd(DEBUG_PARSE, "%s:%d:range\n", zconf_curname(), zconf_lineno());
+};
+
+symbol_option: T_OPTION symbol_option_list T_EOL
+;
+
+symbol_option_list:
+	  /* empty */
+	| symbol_option_list T_WORD symbol_option_arg
+{
+	const struct kconf_id *id = kconf_id_lookup($2, strlen($2));
+	if (id && id->flags & TF_OPTION) {
+		menu_add_option(id->token, $3);
+		free($3);
+	}
+	else
+		zconfprint("warning: ignoring unknown option %s", $2);
+	free($2);
+};
+
+symbol_option_arg:
+	  /* empty */		{ $$ = NULL; }
+	| T_EQUAL prompt	{ $$ = $2; }
+;
+
+/* choice entry */
+
+choice: T_CHOICE word_opt T_EOL
+{
+	struct symbol *sym = sym_lookup($2, SYMBOL_CHOICE);
+	sym->flags |= SYMBOL_AUTO;
+	menu_add_entry(sym);
+	menu_add_expr(P_CHOICE, NULL, NULL);
+	free($2);
+	printd(DEBUG_PARSE, "%s:%d:choice\n", zconf_curname(), zconf_lineno());
+};
+
+choice_entry: choice choice_option_list
+{
+	$$ = menu_add_menu();
+};
+
+choice_end: end
+{
+	if (zconf_endtoken($1, T_CHOICE, T_ENDCHOICE)) {
+		menu_end_menu();
+		printd(DEBUG_PARSE, "%s:%d:endchoice\n", zconf_curname(), zconf_lineno());
+	}
+};
+
+choice_stmt: choice_entry choice_block choice_end
+;
+
+choice_option_list:
+	  /* empty */
+	| choice_option_list choice_option
+	| choice_option_list depends
+	| choice_option_list help
+	| choice_option_list T_EOL
+	| choice_option_list option_error
+;
+
+choice_option: T_PROMPT prompt if_expr T_EOL
+{
+	menu_add_prompt(P_PROMPT, $2, $3);
+	printd(DEBUG_PARSE, "%s:%d:prompt\n", zconf_curname(), zconf_lineno());
+};
+
+choice_option: T_TYPE prompt_stmt_opt T_EOL
+{
+	if ($1->stype == S_BOOLEAN || $1->stype == S_TRISTATE) {
+		menu_set_type($1->stype);
+		printd(DEBUG_PARSE, "%s:%d:type(%u)\n",
+			zconf_curname(), zconf_lineno(),
+			$1->stype);
+	} else
+		YYERROR;
+};
+
+choice_option: T_OPTIONAL T_EOL
+{
+	current_entry->sym->flags |= SYMBOL_OPTIONAL;
+	printd(DEBUG_PARSE, "%s:%d:optional\n", zconf_curname(), zconf_lineno());
+};
+
+choice_option: T_DEFAULT nonconst_symbol if_expr T_EOL
+{
+	if ($1->stype == S_UNKNOWN) {
+		menu_add_symbol(P_DEFAULT, $2, $3);
+		printd(DEBUG_PARSE, "%s:%d:default\n",
+			zconf_curname(), zconf_lineno());
+	} else
+		YYERROR;
+};
+
+choice_block:
+	  /* empty */
+	| choice_block common_stmt
+;
+
+/* if entry */
+
+if_entry: T_IF expr nl
+{
+	printd(DEBUG_PARSE, "%s:%d:if\n", zconf_curname(), zconf_lineno());
+	menu_add_entry(NULL);
+	menu_add_dep($2);
+	$$ = menu_add_menu();
+};
+
+if_end: end
+{
+	if (zconf_endtoken($1, T_IF, T_ENDIF)) {
+		menu_end_menu();
+		printd(DEBUG_PARSE, "%s:%d:endif\n", zconf_curname(), zconf_lineno());
+	}
+};
+
+if_stmt: if_entry if_block if_end
+;
+
+if_block:
+	  /* empty */
+	| if_block common_stmt
+	| if_block menu_stmt
+	| if_block choice_stmt
+;
+
+/* menu entry */
+
+menu: T_MENU prompt T_EOL
+{
+	menu_add_entry(NULL);
+	menu_add_prompt(P_MENU, $2, NULL);
+	printd(DEBUG_PARSE, "%s:%d:menu\n", zconf_curname(), zconf_lineno());
+};
+
+menu_entry: menu visibility_list depends_list
+{
+	$$ = menu_add_menu();
+};
+
+menu_end: end
+{
+	if (zconf_endtoken($1, T_MENU, T_ENDMENU)) {
+		menu_end_menu();
+		printd(DEBUG_PARSE, "%s:%d:endmenu\n", zconf_curname(), zconf_lineno());
+	}
+};
+
+menu_stmt: menu_entry menu_block menu_end
+;
+
+menu_block:
+	  /* empty */
+	| menu_block common_stmt
+	| menu_block menu_stmt
+	| menu_block choice_stmt
+;
+
+source_stmt: T_SOURCE prompt T_EOL
+{
+	printd(DEBUG_PARSE, "%s:%d:source %s\n", zconf_curname(), zconf_lineno(), $2);
+	zconf_nextfile($2);
+	free($2);
+};
+
+/* comment entry */
+
+comment: T_COMMENT prompt T_EOL
+{
+	menu_add_entry(NULL);
+	menu_add_prompt(P_COMMENT, $2, NULL);
+	printd(DEBUG_PARSE, "%s:%d:comment\n", zconf_curname(), zconf_lineno());
+};
+
+comment_stmt: comment depends_list
+;
+
+/* help option */
+
+help_start: T_HELP T_EOL
+{
+	printd(DEBUG_PARSE, "%s:%d:help\n", zconf_curname(), zconf_lineno());
+	zconf_starthelp();
+};
+
+help: help_start T_HELPTEXT
+{
+	if (current_entry->help) {
+		free(current_entry->help);
+		zconfprint("warning: '%s' defined with more than one help text -- only the last one will be used",
+			   current_entry->sym->name ?: "<choice>");
+	}
+
+	/* Is the help text empty or all whitespace? */
+	if ($2[strspn($2, " \f\n\r\t\v")] == '\0')
+		zconfprint("warning: '%s' defined with blank help text",
+			   current_entry->sym->name ?: "<choice>");
+
+	current_entry->help = $2;
+};
+
+/* depends option */
+
+depends_list:
+	  /* empty */
+	| depends_list depends
+	| depends_list T_EOL
+	| depends_list option_error
+;
+
+depends: T_DEPENDS T_ON expr T_EOL
+{
+	menu_add_dep($3);
+	printd(DEBUG_PARSE, "%s:%d:depends on\n", zconf_curname(), zconf_lineno());
+};
+
+/* visibility option */
+
+visibility_list:
+	  /* empty */
+	| visibility_list visible
+	| visibility_list T_EOL
+;
+
+visible: T_VISIBLE if_expr
+{
+	menu_add_visibility($2);
+};
+
+/* prompt statement */
+
+prompt_stmt_opt:
+	  /* empty */
+	| prompt if_expr
+{
+	menu_add_prompt(P_PROMPT, $1, $2);
+};
+
+prompt:	  T_WORD
+	| T_WORD_QUOTE
+;
+
+end:	  T_ENDMENU T_EOL	{ $$ = $1; }
+	| T_ENDCHOICE T_EOL	{ $$ = $1; }
+	| T_ENDIF T_EOL		{ $$ = $1; }
+;
+
+nl:
+	  T_EOL
+	| nl T_EOL
+;
+
+if_expr:  /* empty */			{ $$ = NULL; }
+	| T_IF expr			{ $$ = $2; }
+;
+
+expr:	  symbol				{ $$ = expr_alloc_symbol($1); }
+	| symbol T_LESS symbol			{ $$ = expr_alloc_comp(E_LTH, $1, $3); }
+	| symbol T_LESS_EQUAL symbol		{ $$ = expr_alloc_comp(E_LEQ, $1, $3); }
+	| symbol T_GREATER symbol		{ $$ = expr_alloc_comp(E_GTH, $1, $3); }
+	| symbol T_GREATER_EQUAL symbol		{ $$ = expr_alloc_comp(E_GEQ, $1, $3); }
+	| symbol T_EQUAL symbol			{ $$ = expr_alloc_comp(E_EQUAL, $1, $3); }
+	| symbol T_UNEQUAL symbol		{ $$ = expr_alloc_comp(E_UNEQUAL, $1, $3); }
+	| T_OPEN_PAREN expr T_CLOSE_PAREN	{ $$ = $2; }
+	| T_NOT expr				{ $$ = expr_alloc_one(E_NOT, $2); }
+	| expr T_OR expr			{ $$ = expr_alloc_two(E_OR, $1, $3); }
+	| expr T_AND expr			{ $$ = expr_alloc_two(E_AND, $1, $3); }
+;
+
+/* For symbol definitions, selects, etc., where quotes are not accepted */
+nonconst_symbol: T_WORD { $$ = sym_lookup($1, 0); free($1); };
+
+symbol:	  nonconst_symbol
+	| T_WORD_QUOTE	{ $$ = sym_lookup($1, SYMBOL_CONST); free($1); }
+;
+
+word_opt: /* empty */			{ $$ = NULL; }
+	| T_WORD
+
+%%
+
+void conf_parse(const char *name)
+{
+	const char *tmp;
+	struct symbol *sym;
+	int i;
+
+	zconf_initscan(name);
+
+	sym_init();
+	_menu_init();
+
+	if (getenv("ZCONF_DEBUG"))
+		yydebug = 1;
+	yyparse();
+	if (yynerrs)
+		exit(1);
+	if (!modules_sym)
+		modules_sym = sym_find( "n" );
+
+	tmp = rootmenu.prompt->text;
+	rootmenu.prompt->text = _(rootmenu.prompt->text);
+	rootmenu.prompt->text = sym_expand_string_value(rootmenu.prompt->text);
+	free((char*)tmp);
+
+	menu_finalize(&rootmenu);
+	for_all_symbols(i, sym) {
+		if (sym_check_deps(sym))
+			yynerrs++;
+	}
+	if (yynerrs)
+		exit(1);
+	sym_set_change_count(1);
+}
+
+static const char *zconf_tokenname(int token)
+{
+	switch (token) {
+	case T_MENU:		return "menu";
+	case T_ENDMENU:		return "endmenu";
+	case T_CHOICE:		return "choice";
+	case T_ENDCHOICE:	return "endchoice";
+	case T_IF:		return "if";
+	case T_ENDIF:		return "endif";
+	case T_DEPENDS:		return "depends";
+	case T_VISIBLE:		return "visible";
+	}
+	return "<token>";
+}
+
+static bool zconf_endtoken(const struct kconf_id *id, int starttoken, int endtoken)
+{
+	if (id->token != endtoken) {
+		zconf_error("unexpected '%s' within %s block",
+			id->name, zconf_tokenname(starttoken));
+		yynerrs++;
+		return false;
+	}
+	if (current_menu->file != current_file) {
+		zconf_error("'%s' in different file than '%s'",
+			id->name, zconf_tokenname(starttoken));
+		fprintf(stderr, "%s:%d: location of the '%s'\n",
+			current_menu->file->name, current_menu->lineno,
+			zconf_tokenname(starttoken));
+		yynerrs++;
+		return false;
+	}
+	return true;
+}
+
+static void zconfprint(const char *err, ...)
+{
+	va_list ap;
+
+	fprintf(stderr, "%s:%d: ", zconf_curname(), zconf_lineno());
+	va_start(ap, err);
+	vfprintf(stderr, err, ap);
+	va_end(ap);
+	fprintf(stderr, "\n");
+}
+
+static void zconf_error(const char *err, ...)
+{
+	va_list ap;
+
+	yynerrs++;
+	fprintf(stderr, "%s:%d: ", zconf_curname(), zconf_lineno());
+	va_start(ap, err);
+	vfprintf(stderr, err, ap);
+	va_end(ap);
+	fprintf(stderr, "\n");
+}
+
+static void yyerror(const char *err)
+{
+	fprintf(stderr, "%s:%d: %s\n", zconf_curname(), zconf_lineno() + 1, err);
+}
+
+static void print_quoted_string(FILE *out, const char *str)
+{
+	const char *p;
+	int len;
+
+	putc('"', out);
+	while ((p = strchr(str, '"'))) {
+		len = p - str;
+		if (len)
+			fprintf(out, "%.*s", len, str);
+		fputs("\\\"", out);
+		str = p + 1;
+	}
+	fputs(str, out);
+	putc('"', out);
+}
+
+static void print_symbol(FILE *out, struct menu *menu)
+{
+	struct symbol *sym = menu->sym;
+	struct property *prop;
+
+	if (sym_is_choice(sym))
+		fprintf(out, "\nchoice\n");
+	else
+		fprintf(out, "\nconfig %s\n", sym->name);
+	switch (sym->type) {
+	case S_BOOLEAN:
+		fputs("  bool\n", out);
+		break;
+	case S_TRISTATE:
+		fputs("  tristate\n", out);
+		break;
+	case S_STRING:
+		fputs("  string\n", out);
+		break;
+	case S_INT:
+		fputs("  integer\n", out);
+		break;
+	case S_HEX:
+		fputs("  hex\n", out);
+		break;
+	default:
+		fputs("  ???\n", out);
+		break;
+	}
+	for (prop = sym->prop; prop; prop = prop->next) {
+		if (prop->menu != menu)
+			continue;
+		switch (prop->type) {
+		case P_PROMPT:
+			fputs("  prompt ", out);
+			print_quoted_string(out, prop->text);
+			if (!expr_is_yes(prop->visible.expr)) {
+				fputs(" if ", out);
+				expr_fprint(prop->visible.expr, out);
+			}
+			fputc('\n', out);
+			break;
+		case P_DEFAULT:
+			fputs( "  default ", out);
+			expr_fprint(prop->expr, out);
+			if (!expr_is_yes(prop->visible.expr)) {
+				fputs(" if ", out);
+				expr_fprint(prop->visible.expr, out);
+			}
+			fputc('\n', out);
+			break;
+		case P_CHOICE:
+			fputs("  #choice value\n", out);
+			break;
+		case P_SELECT:
+			fputs( "  select ", out);
+			expr_fprint(prop->expr, out);
+			fputc('\n', out);
+			break;
+		case P_IMPLY:
+			fputs( "  imply ", out);
+			expr_fprint(prop->expr, out);
+			fputc('\n', out);
+			break;
+		case P_RANGE:
+			fputs( "  range ", out);
+			expr_fprint(prop->expr, out);
+			fputc('\n', out);
+			break;
+		case P_MENU:
+			fputs( "  menu ", out);
+			print_quoted_string(out, prop->text);
+			fputc('\n', out);
+			break;
+		default:
+			fprintf(out, "  unknown prop %d!\n", prop->type);
+			break;
+		}
+	}
+	if (menu->help) {
+		int len = strlen(menu->help);
+		while (menu->help[--len] == '\n')
+			menu->help[len] = 0;
+		fprintf(out, "  help\n%s\n", menu->help);
+	}
+}
+
+void zconfdump(FILE *out)
+{
+	struct property *prop;
+	struct symbol *sym;
+	struct menu *menu;
+
+	menu = rootmenu.list;
+	while (menu) {
+		if ((sym = menu->sym))
+			print_symbol(out, menu);
+		else if ((prop = menu->prompt)) {
+			switch (prop->type) {
+			case P_COMMENT:
+				fputs("\ncomment ", out);
+				print_quoted_string(out, prop->text);
+				fputs("\n", out);
+				break;
+			case P_MENU:
+				fputs("\nmenu ", out);
+				print_quoted_string(out, prop->text);
+				fputs("\n", out);
+				break;
+			default:
+				;
+			}
+			if (!expr_is_yes(prop->visible.expr)) {
+				fputs("  depends ", out);
+				expr_fprint(prop->visible.expr, out);
+				fputc('\n', out);
+			}
+		}
+
+		if (menu->list)
+			menu = menu->list;
+		else if (menu->next)
+			menu = menu->next;
+		else while ((menu = menu->parent)) {
+			if (menu->prompt && menu->prompt->type == P_MENU)
+				fputs("\nendmenu\n", out);
+			if (menu->next) {
+				menu = menu->next;
+				break;
+			}
+		}
+	}
+}
+
+#include "zconf.lex.c"
+#include "util.c"
+#include "confdata.c"
+#include "expr.c"
+#include "symbol.c"
+#include "menu.c"
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in

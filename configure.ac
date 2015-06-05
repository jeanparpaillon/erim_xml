dnl
dnl Autoconf initialization
dnl
AC_PREREQ([2.69])
AC_INIT([erim_xml],
	m4_esyscmd([(git describe 2>/dev/null || echo 0.2) | sed 's/^v//' |
        sed 's/-\([0-9]\)-/-0\1-/' | tr -d '\n' || echo 1]),
	[http://github.com/lizenn/erim_xml/issues],
        [erim_xml],
        [https://gtihub.com/lizenn/erim_xml])
AC_CONFIG_SRCDIR([src/erim_xml.erl])
AC_CONFIG_MACRO_DIR([m4])

AC_ERLANG_NEED_ERL
AC_ERLANG_NEED_ERLC

dnl ------------------------------------------------------------------
dnl Versioning.
dnl ------------------------------------------------------------------

dnl Is this a final release?
is_release=0
GITDESC1=`git describe --abbrev=0 || echo 1`
GITDESC2=`git describe --abbrev=4 || echo 1`
if test "${GITDESC1}" = "${GITDESC2}"; then
       is_release=1
fi

dnl
dnl Compilers and all
dnl
AC_PROG_CC
dnl AC_PROG_CXX
dnl AC_PROG_LD
dnl AC_PROG_INSTALL
dnl AC_PROG_MAKE_SET
dnl AC_PROG_SED

AC_ERLANG_SUBST_ROOT_DIR
AC_ERLANG_SUBST_ERTS_VER
AC_ERLANG_CHECK_LIB([erl_interface])

dnl
dnl Libtool
dnl
dnl Hack to skip C++/Fortran tests (stolen from Beep Media Player)
m4_undefine([AC_PROG_CXX])
m4_defun([AC_PROG_CXX],[])
m4_undefine([AC_PROG_F77])
m4_defun([AC_PROG_F77],[])

dnl
dnl Options
dnl

dnl xml lib and backends
AX_LIB_EXPAT
AC_SUBST([HAVE_EXPAT], [`test "$HAVE_EXPAT" = "yes" && echo "true" || echo "false"`])

enable_xml2="no"
AC_ARG_WITH([libxml2],
	    [AS_HELP_STRING([--with-libxml2],
                            [use libxml2 parser from given prefix (ARG=path); check standard prefixes (ARG=yes) or disable (ARG=no)])],
            [
	    if test "$withval" = "yes"; then
	       PKG_CHECK_MODULES([xml2], [libxml-2.0])
	       enable_xml2="yes"
	    elif test -d "$withval"; then
	       xml2_CFLAGS="-I$withval/include"
	       xml2_LIBS="-L$withval/lib -lxml2"
	       enable_xml2="yes"
	    else
	       xml2_CFLAGS=""
	       xml2_LIBS=""
	    fi
	    ],
	    [
	    PKG_CHECK_MODULES([xml2], [libxml-2.0], [enable_xml2="yes"], [enable_xml2="no"])
	    ])
AC_SUBST([HAVE_LIBXML2], [`test "$enable_xml2" = "yes" && echo "true" || echo "false"`])
AC_SUBST([xml2_CFLAGS])
AC_SUBST([xml2_LIBS])

AS_IF([test "$HAVE_EXPAT" != "yes" -a "$enable_xml2" != "yes"], [
   AC_MSG_ERROR([At least one XML parser backend is required (expat or libxml2) !])
])

AC_CONFIG_FILES([
	Makefile
	c_src/Makefile
	rebar.config
])

AC_OUTPUT

xml_backends=""
if test "[$]HAVE_EXPAT" = "yes"; then
  xml_backends="expat"
fi
if test "[$]enable_xml2"; then
  if test -z "[$]xml_backends"; then
    xml_backends="libxml2"
  else
    xml_backends="[$]xml_backends libxml2"
  fi
fi

echo "************************************************************************"
echo " erim_xml configuration is now complete."
echo ""
echo "************************************************************************"
echo "    xml backends  : "$xml_backends
echo ""

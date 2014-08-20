/*
 * Copyright ProcessOne 2006-2010. All Rights Reserved.
 * Copyright Jean Parpaillon 2014. All Rights Reserved.
 *
 * The contents of this file are subject to the Erlang Public License,
 * Version 1.1, (the "License"); you may not use this file except in
 * compliance with the License. You should have received a copy of the
 * Erlang Public License along with this software. If not, it can be
 * retrieved online at http://www.erlang.org/.
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
 * the License for the specific language governing rights and limitations
 * under the License.
 *
 */

#ifndef ERIM_DRIVER_H
#define	ERIM_DRIVER_H 1

#if defined(HAVE_CONFIG_H)
#include "config.h"
#endif

#include <ei.h>
#include <erl_driver.h>

/*
 * R15B changed several driver callbacks to use ErlDrvSizeT and
 * ErlDrvSSizeT typedefs instead of int.
 * This provides missing typedefs on older OTP versions.
 */
#if ERL_DRV_EXTENDED_MAJOR_VERSION < 2
typedef int ErlDrvSizeT;
typedef int ErlDrvSSizeT;
#endif

/*
 * This macro is used to stringify the driver name in the driver's
 * ErlDrvEntry. One use it like this:
 *     static ErlDrvEntry driver_entry = {
 *             ...
 *             S(DRIVER_NAME),)
 *             ...
 *     };
 */

#define	_S(s)		#s
#define	S(s)		_S(s)

/*
 * On Win32, strdup(3) exists under the name _strdup.
 */

#if defined(_WIN32)
#define	strdup(s) _strdup(s)
#endif

/* Simple hashtable. */
struct erim_hashtable;

typedef void erim_ht_free_value_cb(void *value);

struct erim_hashtable *	erim_ht_create(unsigned int min_length,
				    erim_ht_free_value_cb free_value);
int				erim_ht_store(struct erim_hashtable *ht,
				    const char *key, int key_len,
				    void *value);
void *				erim_ht_fetch(struct erim_hashtable *ht,
				    const char *key, int key_len);
int				erim_ht_exists(struct erim_hashtable *ht,
				    const char *key, int key_len);
void				erim_ht_destroy(struct erim_hashtable *ht);
void				erim_ht_dump_keys(struct erim_hashtable *ht);

/*
 * The follwing function help in reading and preparing the buffers which are
 * exchanged with Erlang.
 */

int		erim_skip_version(const char *buf);
ei_x_buff *	erim_new_xbuf(void);
void		erim_free_xbuf(ei_x_buff *xbuf);

/* This function uses driver_alloc() but behaves as strdup(3) otherwise. */
char *		erim_strdup(const char *str);

#endif /* !defined(ERIM_DRIVER_H) */

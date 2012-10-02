#! /usr/bin/env python
# encoding: utf-8
# Copyright © 2012 aligo Kang

APPNAME = 'qiaoke'
VERSION = '0.0.1'

top = '.'
out = 'build'

import waflib

def options(opt):
  opt.load(['compiler_c', 'vala'])

  opt.add_option('--debug',
    help = 'Debug mode',
    action = 'store_true',
    default = False)

  opt.add_option('--custom-flags',
    help = 'Use the user defined CFLAGS/LDFLAGS/VALAFLAGS only'
    ' instead of the defaults ones followed by the'
    ' user ones.',
    action = 'store_true',
    default = False)

def configure(conf):
  CFLAGS = list()
  VALAFLAGS = list()
  LINKFLAGS = list()

  conf.load(['compiler_c', 'vala'])

  conf.load('vala', funs = '')
  conf.check_vala(min_version = (0, 12, 1))

  glib_package_version = '2.16.0'

  conf.check_cfg(
    package         = 'glib-2.0',
    uselib_store    = 'GLIB',
    atleast_version = glib_package_version,
    args            = '--cflags --libs')

  conf.check_cfg(
    package         = 'gobject-2.0',
    uselib_store    = 'GOBJECT',
    atleast_version = glib_package_version,
    args            = '--cflags --libs')

  conf.check_cfg(
    package         = 'gthread-2.0',
    uselib_store    = 'GTHREAD',
    atleast_version = glib_package_version,
    args            = '--cflags --libs')

  conf.check_cfg(
    package         = 'gtk+-2.0',
    uselib_store    = 'GTK',
    atleast_version = '2.16',
    args            = '--cflags --libs')

  conf.check_cfg(
    package         = 'vte',
    uselib_store    = 'VTE',
    atleast_version = '0.28',
    args            = '--cflags --libs')

  CFLAGS.extend(['-I/usr/local/include', '-include', 'config.h'])
  VALAFLAGS.extend(['--thread'])
  conf.define('VERSION', VERSION)

  if conf.options.debug == True:
    CFLAGS.extend(['-ggdb3'])
    VALAFLAGS.extend(['-g', '--enable-experimental-non-null', '--enable-checking'])
  elif conf.options.custom_flags == False:
    CFLAGS.extend(['-pipe', '-O2'])
    LINKFLAGS.extend(['-Wl,-O1', '-s'])

  conf.env.prepend_value('CFLAGS', CFLAGS)
  conf.env.prepend_value('VALAFLAGS', VALAFLAGS)
  conf.env.prepend_value('LINKFLAGS', LINKFLAGS)

  conf.write_config_header('config.h')

def build(bld):

  bld.program(
    packages      = ['vte', 'config', 'posix', 'tomboykeybinder'],
    vapi_dirs     = 'vapi',
    target        = APPNAME,
    uselib        = ['GLIB', 'GOBJECT', 'GTHREAD', 'GTK', 'VTE'],
    source        = [
                      'src/main.vala',
                      'src/main-window.vala',
                      'src/config.vala',
                      'src/config-file.vala',
                      'src/config-signal.vala',
                      'src/errors.vala',
                      'src/hotkey.vala',
                      'src/terminal.vala',
                      'src/terminal-manager.vala',
                      'src/terminal-menu.vala',
                      'src/terminal-box.vala',
                      'src/terminal-killer.vala',
                      'src/rename-dialog.vala',
                      'src/search-dialog.vala',
                      'src/colors.vala',
                      'deps/eggaccelerators.c',
                      'deps/tomboykeybinder.c'
                     ],
    includes      = ['deps/'])
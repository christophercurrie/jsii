import { KernelHost } from './host'
import { InputOutput } from './in-out'

const name    = require('../package.json').name;
const version = require('../package.json').version;

const noStack = !!process.env.JSII_NOSTACK;
const debug = !!process.env.JSII_DEBUG;

const inout = new InputOutput();
const host = new KernelHost(inout, { debug, noStack });

// say hello
inout.write({ hello: `${name}@${version}` });
inout.debug = debug; // we don't want "hello" emitted

host.run();

#include "vfun.h"

const int verrazano_binding = 0;

baser::baser(int value)
	:myValue(value) {}

int baser::get_value()
{
	return myValue;
}

base::base(int value)
	:myValue(value) {}

base::~base() {}

int base::get_value()
{
	return myValue;
}

int base::set_value(int val)
{
	myValue = val;
}

int base::get_id()
{
	return 1001;
}

derived::derived(int value)
	:base(value) {}

int derived::get_id()
{
	return 1337;
}


extern "C"
{

struct a;
struct b;
struct c;
struct q;

void caps_sensitive() {}
void CaPs_SeNsItIvE() {}

enum foo 
{
	ENUM_A, 
	ENUM_B
};

typedef struct _recb recb;


typedef struct _reca
{
	recb* next;
	int   bit1 :8;
} reca;

struct _recb
{
	reca* next;
};

struct a
{
	b* foo1;
	struct aa
	{
		b* foo2;
	} my_a;
};

struct b
{
	int foo2;
};

struct c
{
	a* foo3;
	b* foo2;
	q* foo6;
};

struct q
{
	a* foo4;
	b* foo5;
};

void my_foo();

}

class mybase
{
	public:
		virtual ~mybase();
		int my_method();
		virtual int my_method2();
		virtual int my_own_method();
		virtual int my_own_method(int foo);
		static int do_something();
		int operator+(int rhs);
		operator int*();
	private:
		int my_private_method();
		int mydata;
};

class myclass :public mybase
{
	public:
		virtual int my_method2();
		int my_method3();
		virtual int my_method4();
};

class yetanotherbase
{
	public:
		virtual int my_method5();
		virtual int my_method6();
};

class mything :public myclass, public yetanotherbase
{
};
	
typedef char char_array[10];

struct array_struct
{
	char_array var;
};

void frob_array(char_array ar);


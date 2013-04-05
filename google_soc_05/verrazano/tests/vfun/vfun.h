typedef char char_array[255];

#define MY_VAR 200
#define MY_VAR2 0x100

void frob_array(char_array ar);

class baser
{
	public:
		baser(int value);
		virtual int get_value();
	private:
		int myValue;
};

class base
{
	public:
		base(int value);
		virtual ~base();
		virtual int get_value();
		virtual int set_value(int val);
		virtual int get_id();
	private:
		int myValue;
};

class derived :public base
{
	public:
		derived(int value);
		virtual int get_id();
};


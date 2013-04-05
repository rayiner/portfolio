% Driver script for Quiz 1

% constants given in problem
T = 15000;
cla = 5.7;
sigma = 0.1;
Nb = 3;
Vtip = 650;
R = 43 / 2;
c81TableSize = [12 40; 12 66];

% constants derived from the problem
rho = 0.001921;
A = pi * R^2;
a = 1154.270397;
Ct = T / (rho * A * Vtip^2);
omega = Vtip / R;

% load the NACA 0012 tables
c81_table('load', 'naca0012', c81TableSize)

% our blade stations
blade = linspace(0.07, 1.0, 50);

% our test axes
taperRatios = linspace(0.7, 1.0, 20);
twistRates = -linspace(0, 30, 20) * pi / 180;
fomResults = zeros(length(taperRatios), length(twistRates));

for i = 1:length(taperRatios)
	for j = 1:length(twistRates)
		Tr = taperRatios(i);
		theta_tw = twistRates(j);
		[cp ct] = bemt(blade, Ct, cla, sigma, theta_tw, Nb, Tr, a, omega, R);
		
		fom = ct^(3/2) / sqrt(2) / cp;
		fomResults(i, j) = fom;
		
		fprintf('%f At taper = %f and tw = %f, fom = %f\n', ct, Tr, theta_tw * 180 / pi, fom);
	end
end

function [ret] = c81_table(op, arg1, arg2)
% access the C81 table for an airfoil
% table is two text files, one with CL and one with Cd data
% the interface is weird, and has threes operations
% op == 'load' signifies that C81 tables should be loaded into memory
% op == 'lookup_cl' signifies a CL lookup with given M and alpha
% op == 'lookup_cd' signifies a CD lookup with given M and alpha
% for loads, arg1 is the common part of the filename, arg2 is size matrix
% for lookups, arg1 is M, arg2 is alpha
	global CL_INDEX_A 
	global CL_INDEX_M 
	global CD_INDEX_A 
	global CD_INDEX_M 
	global CL_TABLE  
    global CD_TABLE 
	
	if strcmp(op, 'load')
		liftTable = strcat(arg1, '.cl');
		dragTable = strcat(arg1, '.cd');
		
		[CL_INDEX_A CL_INDEX_M CL_TABLE] = load_table(liftTable, arg2(1, :));
		[CD_INDEX_A CD_INDEX_M CD_TABLE] = load_table(dragTable, arg2(2, :));
	elseif strcmp(op, 'lookup_cl')
		ret = interp2(CL_INDEX_M, CL_INDEX_A, CL_TABLE, arg1, arg2);
	elseif strcmp(op, 'lookup_cd')
		ret = interp2(CD_INDEX_M, CD_INDEX_A, CD_TABLE, arg1, arg2);
	end

function [rowIndex colIndex table] = load_table(fileName, size)
% load a CL or CD table from a file
% return the row index (alpha), column index (M), and CL values
	fid = fopen(fileName, 'rt');
	[A, count] = fscanf(fid, '%f', size);
	A = transpose(A);
	rowIndex = transpose(A(2:end,1));
	colIndex = A(1,2:end);
	table = A(2:end,2:end);
	fclose(fid);

function [cp ct] = bemt(blade, ct_guess, cla, sigma, theta_tw, Nb, Tr, a, omega, R)
% Compute cp, ct on rotor 'blade' using given constants

% guess a value of theta that is roughly accurate
theta_guess = 6*ct_guess/(sigma*cla) + 3/2*sqrt(ct_guess/2);

% use optimizer to minimize the computed Ct from the assummed Ct
tg = fminbnd(@mindeltact, 0.5*theta_guess, 1.5*theta_guess, [], ...
	blade, ct_guess, cla, sigma, theta_tw, Nb, Tr, a, omega, R);
[cp ct] = bemt_iteration(blade, ct_guess, tg, cla, sigma, theta_tw, Nb, Tr, a, omega, R);


% the minimization function that computes Ct_computed - Ct_assumed
function f = mindeltact(tg, blade, ct_guess, cla, sigma, theta_tw, Nb, Tr, a, omega, R)
[cp ct] = bemt_iteration(blade, ct_guess, tg, cla, sigma, theta_tw, Nb, Tr, a, omega, R);
f = abs(ct - ct_guess);



function [cp ct] = bemt_iteration(blade, ct_guess, tg, cla, sigma_twa, theta_tw, Nb, Tr, a, omega, R)
% one iteration of the BEMT procedure
% compute cp, ct using BEMT and given variables
% tg is a guess at theta_0

cp = 0;
ct = 0;

% iterate through segments in blade
for i = 2:length(blade)
	% compute segment parameters
	r = mean(blade(i-1:i));
	dr = blade(i) - blade(i - 1);
	sa = sigma_twa / (1 + 0.75 * (Tr - 1));
	sb = (Tr - 1) * sa;
	sigma_i = sa + sb * r;
	M = omega * r * R / a;
	
	% compute effective angle of attack
	theta = tg + (r - 0.75) * theta_tw;
	
	% compute the inflow adjusted for tip loss
	F = 1;
	dF = 1;
	
	% iterate on lambda_i and F until F converges
	while dF > 0.001
		lambda_i = sigma_i*cla/(16*F) *(sqrt(1+(32*F)/(sigma_i*cla)*theta*r)-1);
		alpha_i = atan2(lambda_i, r);
		alpha_eff = theta - alpha_i;

		Fold = F;
		F = prandtl_loss(Nb, r, alpha_i);
		dF = abs(F - Fold);
    end

	% compute lift/drag coefficients
	cl = c81_table('lookup_cl', M, alpha_eff * 180 / pi);
	cd = c81_table('lookup_cd', M, alpha_eff * 180 / pi);
		
	% update numeric integral
	dcp = (sigma_i/2*r^3*(cd*cos(alpha_i)+cl*sin(alpha_i)));
	dct = (sigma_i/2*r^2*(cl*cos(alpha_i)-cd*sin(alpha_i)));
	cp = cp + dcp * dr;
	ct = ct + dct * dr;
end

function F = prandtl_loss(Nb, r, alpha_i)
% compute the prandtl tip loss function
f = Nb / 2 * ((1 - r)/(r*alpha_i));
F = 2/pi * acos(exp(-f));


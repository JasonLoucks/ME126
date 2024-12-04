%% TransientConductionTable.m
% Jason Loucks
%
% Fills in a table of temperatures in deg C using Eq. 4.14 with q_gen = 0.

fprintf( "Enter givens below. Pay attention to requested units!\n" );

% Physical Parameters
k = input( "Enter k in W/m K:\n> " );    % W/m K
c = input( "Enter c in J/kg K:\n> " );   % J/kg K
p = input( "Enter rho in kg/m^3:\n> " ); % kg/m^3

% Table Info
T = input( "Enter the T values in degrees C at t = 0\nas an array (e.g. ""[ 1 2 3 4 5 ]"":\n> "); % deg C
rows = input( "Enter number of rows in the table:\n> " );
dt = input( "Enter time step size (delta t) in minutes:\n> "); % min
dx = input( "Enter depth step size (delta x) in cm:\n> "); % cm

cols = length( T );

a = k / ( c * p );
adtdx = a * ( ( dt * 60 ) / ( dx / 100 )^2 ); % constant used if q_gen = 0, assumes dt is in min and dx is in cm

% T_i,m = T( m, i )
for m = 1:( rows - 1 )
    for i = 1:cols
        if ( i == 1 ) || ( i == cols )
            T( m + 1, i ) = T( m, i ); % temps at wall boundaries do not change
        else
            T( m + 1, i ) = T( m, i ) + adtdx * ( T( m, i + 1 ) - 2 * T( m, i ) + T( m, i - 1 ) );
        end
    end
end

T % display the final table
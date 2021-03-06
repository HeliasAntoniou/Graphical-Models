function optimalPath = airplaneFaultyMDP(U)
%DEMOMDP demo of solving Markov Decision Process on a grid
import brml.*
load('airplane');
Gx = 18; Gy = 15;  % two dimensional grid size
S = Gx*Gy; % number of states on grid
st = reshape(1:S,Gx,Gy); % assign each grid point a state

A = 5;  % number of action (decision) states
[stay up down left right] = assign(1:A); % actions (decisions)
p = zeros(S,S,A); % initialise the transition p(xt|xtm,dtm) ie p(x(t)|x(t-1),d(t-1))

% make a deterministic transition matrix on a 2D grid:
for x = 1:Gx
	for y = 1:Gy
		p(st(x,y),st(x,y),stay)=1; % can stay in same state
		if validgridposition(x+1,y,Gx,Gy)
            if ~validgridposition(x,y+1,Gx,Gy)
                p(st(x+1,y),st(x,y),right)=1;
            else
                p(st(x+1,y),st(x,y),right)=0.9;
                p(st(x,y+1),st(x,y),up)=0.1;
            end
		end
		if validgridposition(x-1,y,Gx,Gy)
			p(st(x-1,y),st(x,y),left)=1;
		end
		if validgridposition(x,y+1,Gx,Gy)
            if ~validgridposition(x+1,y,Gx,Gy)
                p(st(x,y+1),st(x,y),up)=1;
            end
		end
		if validgridposition(x,y-1,Gx,Gy)
			p(st(x,y-1),st(x,y),down)=1;
		end
	end
end
% define utilities
u = reshape(U,270,1);
gam = 0.95; % discount factor

figure; imagesc(reshape(u,Gx,Gy)); colorbar; title('utilities'); pause


[xt xtm dtm]=assign(1:3); % assign the variables x(t), x(t-1), d(t-1) to some numbers
% define the transition potentials p(x(t)|x(t-1),d(t-1))
tranpot=array([xt xtm dtm],p);
% setup the value potential v(x(t))
valpot=array(xt,ones(S,1)); % initial values

maxiterations=30; tol=0.001; % termination criteria
% Value Iteration:
oldvalue=valpot.table;
for valueloop=1:maxiterations
	valueloop
	tmppot = maxpot(sumpot(multpots([tranpot valpot]),xt),dtm);
    disp(size(tmppot))
	valpot.table = u + gam*tmppot.table; % Bellman's recursion
	if mean(abs(valpot.table-oldvalue))<tol; break; end % stop if converged
	oldvalue = valpot.table;
	imagesc(reshape(valpot.table,Gx,Gy)); colorbar; drawnow
end
figure; bar3zcolor(reshape(valpot.table,Gx,Gy));

% Policy Iteration:
valpot.table=ones(S,1); % initial values
oldvalue=valpot.table;
figure;
for policyloop=1:maxiterations
	policyloop
	% Policy evaluation: get the optimal decisions as a function of the state:
	[tmppot dstar] = maxpot(sumpot(multpots([tranpot valpot]),xt),dtm);
	for x1=1:S
		for x2=1:S
			pdstar(x1,x2) = p(x2,x1,dstar(x1));
		end
	end
	valpot.table = (eye(S)-gam*pdstar)\u;
	if mean(abs(valpot.table-oldvalue))<tol; break; end % stop if converged
	oldvalue=valpot.table;
	imagesc(reshape(valpot.table,Gx,Gy)); colorbar; drawnow
end
figure; bar3zcolor(reshape(valpot.table,Gx,Gy));

% find the optimal sequence of positions
valmap = reshape(valpot.table,Gx,Gy);
sequence = [1 13];
position = [1 13];
xpost = 1; % starting position
ypost = 13;
for i = 1:40
    valself = valmap(xpost,ypost);
    if validgridposition(xpost+1,ypost,Gx,Gy)
        valright = valmap((xpost+1),(ypost));
    else valright = -100;
    end
    if validgridposition(xpost-1,ypost,Gx,Gy)
        valleft = valmap((xpost-1),(ypost));
    else valleft = -100;
    end
    if validgridposition(xpost,ypost+1,Gx,Gy)
        valup = valmap((xpost),(ypost+1));
    else valup = -100;
    end
    if validgridposition(xpost,ypost-1,Gx,Gy)
        valdown = valmap((xpost),(ypost-1));
    else valdown= -100;
    end
    
    maxVector = [valself valright valleft valup valdown];
    [val idx] = max(maxVector);
    
    if idx == 1 % stay
        xpost = xpost;
        ypost = ypost;
    elseif idx == 2 % move right
        xpost = xpost+1;
        upost = ypost;
    elseif idx == 3 % move left
        xpost = xpost-1;
        ypost = ypost;
    elseif idx == 4 % move up
        xpost = xpost;
        ypost = ypost+1;
    elseif idx == 5 % move down
        xpost = xpost;
        ypost = ypost-1;
    end
       
    sequence(i+1,:) = [xpost ypost];
end



cut_off = 100; % finite time horizon
opts.maxiterations=3; opts.tol=0.00001;  opts.plotprogress=1;
% rewards can also be a function of the action u(x,a), so make a reward
% that accounts for this:
[value action] = MDPemDeterministicPolicy(p,repmat(u', A, 1), cut_off, S, A, gam,opts);
figure; imagesc(reshape(value,Gx,Gy)); colorbar; drawnow; title('EM deterministic policy value')
figure; bar3zcolor(reshape(valpot.table,Gx,Gy)); title('EM deterministic policy value')
y = sum(U)/length(U); 

optimalPath = sequence;

end
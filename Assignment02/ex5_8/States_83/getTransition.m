function A = getTransition()
    A = ones(1,1)*0.8;
    
    A = [A; zeros(82,1)];
    A(2,:) = 0.04;
    A(7,:) = 0.04;
    A(12,:) = 0.04;
    A(16,:) = 0.04;
    A(19,:) = 0.04;
    
    A = [A zeros(83,22)];
    A(3,2) = 1;
    A(4,3) = 1;
    A(5,4) = 1;
    A(6,5) = 1;
    A(24,6) = 1.0;
    A(8,7) = 1;
    A(9,8) = 1;
    A(10,9) = 1;
    A(11,10) = 1;
    A(24,11) = 1.0;
    A(13,12) = 1;
    A(14,13) = 1;
    A(15,14) = 1;
    A(24,15) = 1.0;
    A(17,16) = 1;
    A(18,17) = 1;
    A(24,18) = 1.0;
    A(20,19) = 1;
    A(21,20) = 1;
    A(22,21) = 1;
    A(23,22) = 1;
    A(24,23) = 1.0;
    
    Hmatrix = zeros(83,1);
    Hmatrix(24,1) = 0.8;
    Hmatrix(25,1) = 0.02857;
    Hmatrix(31,1) = 0.02857;
    Hmatrix(37,1) = 0.02857;
    Hmatrix(40,1) = 0.02857;
    Hmatrix(45,1) = 0.02857;
    Hmatrix(56,1) = 0.02857;
    Hmatrix(67,1) = 0.02857;
    A=[A Hmatrix];
    clear Hmatrix;

    A_help = A;
    A = [A zeros(83,59)];
    A(76,75) = 1;
    A(77,76) = 1;
    A(78,77) = 1;
    A(79,78) = 1;
    A(80,79) = 1;
    A(82,81) = 1;
    A(83,82) = 1;
    A(84,83) = 1;
    A(85,84) = 1;
    A(86,85) = 1;
    A(88,87) = 1;
    A(89,88) = 1;
    A(91,90) = 1;
    A(92,91) = 1;
    A(93,92) = 1;
    A(94,93) = 1;
    A(96,95) = 1;
    A(97,96) = 1;
    A(98,97) = 1;
    A(99,98) = 1;
    A(100,99) = 1;
    A(101,100) = 1;
    A(102,101) = 1;
    A(103,102) = 1;
    A(104,103) = 1;
    A(105,104) = 1;
    A(107,106) = 1;
    A(108,107) = 1;
    A(109,108) = 1;
    A(110,109) = 1;
    A(111,110) = 1;
    A(112,111) = 1;
    A(113,112) = 1;
    A(114,113) = 1;
    A(115,114) = 1;
    A(116,115) = 1;
    A(118,117) = 1;
    A(119,118) = 1;
    A(120,119) = 1;
    A(121,120) = 1;
    A(122,121) = 1;
    A(123,122) = 1;
    A(124,123) = 1;
    A(125,124) = 1;
    A(126,125) = 1;
    A(127,126) = 1;
    A(128,127) = 1;
    A(129,128) = 1;
    A(130,129) = 1;
    A(131,130) = 1;
    A(132,131) = 1;
    A(133,132) = 1;
    A(133,133) = 0;
    help = [zeros(24,59) ; A(75:133,75:133)];
    clear A;
    A_help = [A_help help];
    A = A_help;
    A(1,30) = 1.0;
    A(1,36) = 1.0;
    A(1,39) = 1.0;
    A(1,44) = 1.0;
    A(1,55) = 1.0;
    A(1,66) = 1.0;
    A(1,83) = 1.0;
    clear A_help; clear help;
end
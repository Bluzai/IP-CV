function [ out ] = iIFFT( img )
%IIFFT Summary of this function goes here
%   Detailed explanation goes here
    [m0,n0] = size(img);
    % Recognise if m0 is power of 2 or not
    if mod(m0,2) == 1
        m = m0+1;
    else
        m = m0;
    end
    if log2(m) ~= fix(log2(m))
        m = 2^(fix(log2(m))+1);
    end
    % Recognise if n0 is power of 2 or not
    if mod(n0,2) == 1
        n = n0+1;
    else
        n = n0;
    end
    if log2(n) ~= fix(log2(n))
        n = 2^(fix(log2(n))+1);
    end
    temp = zeros(m,n);
    for u = 1 : m0
        for v = 1 : n0
            temp(u,v) = img(u,v);
        end
    end
    img = temp;
    if m < n
        n1 = n;
    else
        n1 = m;
    end
    nb = log2(n1);
    % Decenter Fourier
%     for x = 0 : m-1
%         for y = 0 : n-1
%             img(x+1,y+1) = (1^(x+y))*img(x+1,y+1);
%         end
%     end
    % Row bit reversal start
    p_m = 0 : m-1; 
    nb_m = log2(m);
    p1_m = p_m;
    b_m = zeros(1,m);
    for t = 1 : nb_m
        b_m = b_m*2 + mod(p1_m,2);
        p1_m = floor(p1_m/2);
    end
    % Column bit reversal start
    p_n = 0 : n-1; 
    nb_n = log2(n);
    p1_n = p_n;
    b_n = zeros(1,n);
    for t = 1 : nb_n
        b_n = b_n*2 + mod(p1_n,2);
        p1_n = floor(p1_n/2);
    end
    temp(p_m+1,p_n+1) = img(b_m+1,b_n+1);
    img = temp;
    % Bit reversal end
    % Calculate row w(from w(0) to w(m/2-1)) start
    w_m = zeros(1,n1/2-1);
    for t = 0 : m/2-1
        w_m(t+1) = exp(2*1i*pi*t/m);
    end
    % Calculate column w(from w(0) to w(n/2-1)) start
    w_n = zeros(1,n1/2-1);
    for t = 0 : n/2-1
        w_n(t+1) = exp(2*1i*pi*t/n);
    end
    % Calculate end
    temp = zeros(size(img));
    % Calculate Fourier start
    for s = 1 : nb
        m_m = 2^(s-1);
        m_n = 2^(s-1);
        for b_m = 1 : 2^(nb_m - min(s,nb_m))
            k = 2*(b_m - 1) * m_m + 1;
            for t_k = 1 : m_m
                % Determine the power of w over x
                pw_k = mod((k-1) * 2^(nb - s), 2^nb) + 1;
                for b_n = 1 : 2^(nb_n - min(s,nb_n))
                    j = 2*(b_n - 1) * m_n + 1;
                    for t_j = 1 : m_n
                        if s > nb_m
                            m_m = 0;
                        end
                        if s > nb_n
                            m_n = 0;
                        end
                        % Determine the power of w over y
                        pw_j = mod((j-1) * 2^(nb-s), 2^nb) + 1;
                        temp(k,j) = img(k,j) + w_n(pw_j)*img(k,j+m_n) + w_m(pw_k)*img(k+m_m,j) + w_m(pw_k)*w_n(pw_j)*img(k+m_m,j+m_n);
                        temp(k+m_m,j) = img(k,j) + w_n(pw_j)*img(k,j+m_n) - w_m(pw_k)*img(k+m_m,j) - w_m(pw_k)*w_n(pw_j)*img(k+m_m,j+m_n);
                        temp(k,j+m_n) = img(k,j) - w_n(pw_j)*img(k,j+m_n) + w_m(pw_k)*img(k+m_m,j) - w_m(pw_k)*w_n(pw_j)*img(k+m_m,j+m_n);
                        temp(k+m_m,j+m_n) = img(k,j) - w_n(pw_j)*img(k,j+m_n) - w_m(pw_k)*img(k+m_m,j) + w_m(pw_k)*w_n(pw_j)*img(k+m_m,j+m_n);
                        j = j+1;
                    end
                end
                k = k+1;
            end
        end
        img = temp;
    end
    % Calculate end
    out = abs(img);
end


;practice1.2
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))) (* 3 (- 6 2) (- 2 7))))

;practice1.3
(define (square x) (* x x))
(define (sum-of-square x y) (+ (square x) (square y)))
(define (sum-of-square-from-three x y z) 
  (cond ((and (<= x y) (<= x z)) (sum-of-square y z))
        ((and (<= y x) (<= y z)) (sum-of-square x z))
        (else (sum-of-square x y))))

; (print (sum-of-square-from-three 1 2 3))

;practice1.5
;
;(define (p) (p))
;(define (test x y) (if (= x 0) 0 y))
;(test 0 (p))
; This will return nothing, because (p) will keep calling itself indefinitely.

; newton's method for approximating square roots
(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess))
)

(define (average x y)
  (/ (+ x y) 2))

;(print (sqrt 0.00000000123))

;practice1.6
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (average x y) (/ (+ x y) 2))

(define (square x) (* x x))

(define (improve guess x) (average guess (/ x guess)))

(define (good-enough? guess x)
(< (abs (- (square guess) x)) 0.001))


(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))

; schemeの適用順序評価で関数を実行するため、ifを関数として使うと引数に渡した関数が先に評価され無限ループになってしまう。

;practice1.7
; 
;guess = 3513641.86446, (improve guess x) = 3513641.82882 以降は収束せず無限ループになってしまう。
;これは、浮動小数点数の表現方法に起因する問題で64bitのコンピュータでは、浮動小数点の有効桁数は2進数で53桁、10進数で約15～16桁のため、それ以上の桁数の計算は64bitのコンピューターでは表現できないことに起因する。
;(define (improve guess x)
;  (average guess (/ x guess)))
; 
;   x           = 12345678901234
;   guess       = 3513641.8288200637
;   (\ x guess) = 3513641.8288200633
;   
;   improve guessは 推定値と x を割った値の平均を取る
;   (define (average x y) 
;     (/ (+ x y) 2))
;
;   (+ x y)        = 7027283.6576401274
;   (/ (+ x y) 2)) = 3513641.8288200637 ; guessと同じ値になる
; 
;   上記の値を２進数で表すと以下のようになる
;                 S Exponent    Mantissa
;   guess       = 0 10000010100 10101100111010010100111010100001011011000110100111**10** (3513641.8288200637)
;   (\ x guess) = 0 10000010100 10101100111010010100111010100001011011000110100111**01** (3513641.8288200633)
;
;   上記理由から推定値が一定回数のループ以降は改善されなくなる。
;   この状態で、推定値とxの誤差を計算すると以下のようになる。
;   (square guess)       = 12345678901234.00195
;   (abs (- (square guess) x))       = 0.00195 ; > 0.001
;  
;   よって、good-enough?の条件を満たさず無限ループとなってしまう。

(define (square x) (* x x))

(define (good-enough? previous-guess guess)
  (< (abs (/ (- guess previous-guess) guess)) 0.00000000001))

(define (sqrt-iter guess x)
  (if (good-enough? guess (improve guess x))
      guess
      (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt x)
  (sqrt-iter 1.0 x))

;(print (sqrt 123456789012345))


;practice1.8
(define (cube x) (* x x x))

(define (good-enough? previous-guess guess)
  (< (abs (/ (- guess previous-guess) guess)) 0.00000000001))

(define (cube-root-iter guess x)
  (if (good-enough? guess (improve guess x))
      guess
      (cube-root-iter (improve guess x) x)))

(define (improve guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))

(define (cube-root x)
  (cube-root-iter 1.0 x))

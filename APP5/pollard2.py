from math import gcd


def inverse_multiplicatif(a, n):
    hg = n
    hv = 0
    bg = a
    bv = 1
    while bg != 0:
        t = hg // bg

        tg = bg
        bg = hg - t * bg
        hg = tg

        tv = bv
        bv = hv - t * bv
        hv = tv

    return hv


def pollard(n):
    m = 2
    for i in range(1, 100000):
        m = pow(m, i, n)
        if gcd(n, m-1) != 1:
            return gcd(n, m-1)

print("------Factorisation------")
n = 86062381025757488680496918738059554508315544797
p = pollard(n)
q = n//p
print("P: " + str(p))
print("Q: " + str(q))
if p * q == n:
    print("This is correct")

print("------Trouver d------")
phi = (p-1)*(q-1)
e = 13
d = inverse_multiplicatif(e, phi)
if d < 0:
    d = phi + d
print("D: " + str(d))


employees = {"alain": 81530476374664351124876242644701327168836407987,
             "michele":	83740877821201430552252653974153238737996745098,
             "stephanie": 51373667846507963545859239582447701017826406175,
             "fernand":	61167846837720209456441528754183777549647735855,
             "angele": 42340513171888188994504759277496496710896088718,
             "bernard":	65069303637151076134861115122997306654987857614,
             "claude": 32785990179062766920584737848735367794508677603}

for name, salary_enc in employees.items():
    salary = pow(salary_enc, d, n)
    print(name + ":" + str(salary))

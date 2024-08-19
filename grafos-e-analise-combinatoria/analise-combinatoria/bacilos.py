def main():
  T = int(input().strip())
  remainders = [0] * T
  bacilli_mod = [1, 1] + [0] * 1498

    for i in range(T):
        remainder = 0
        k = input().strip()
        for c in k:
            remainder = (remainder * 10 + int(c)) % 1500
        remainders[i] = remainder

    for i in range(2, 1500):
        bacilli_mod[i] = (bacilli_mod[i - 1] + bacilli_mod[i - 2]) % 1000
    
    for i in range(T):
        print("{:03d}".format(bacilli_mod[remainders[i] - 1]))

if __name__ == "__main__":
    main()

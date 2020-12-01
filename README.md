# sena-- 

Esta linguagem está sendo desenvolvida na disciplina de compiladores. A linguagem ainda não está completa, aceita tipo inteiro, real e texto.

#### Marcadores de início e fim do programa
```
inicio
    @@ código 
    @@ ...
fim
```

#### Comentários
```
@@ para comentar uma linha, adicione dois arrobas na frente da linha
```

#### Tipos
- real: aceita um número inteiro `a << 10` ou real `a << 10.0`
- inteiro: aceita um número inteiro `a << 10` e converte número real `a << 10.5` fica `a = 10`
- texto: aceita um texto `nome << "Lucas"`

#### Declaração de variáveis
- com um caractere
```
real a
inteiro b
texto c
```
- mais de um caractere
```
real soma 
inteiro subtracao
texto nomeOperacao
```
- misturando letras e números
```
real soma1
inteiro subtracao2
texto nomeOperacao1
```
- mais de uma variável
```
real x, y, area
inteiro time1, time2
texto nome, sobrenome
```

#### Atribuição de valores
```
inteiro a << 5
real b, soma
texto nomeOperacao << "Soma da operação: "

b << 10.5
soma << a + b
```

#### Operação de escrita
```
escreva("Hello Word!")
escreva(a)
escreva(5.0)
escreva(a + b)
escreva(nomeOperacao)
```

#### Operação de leitura
```
inteiro idade
real peso
texto nome

escreva("Digite seu nome: ")
leia(nome)

escreva("Digite sua idade: ")
leia(idade)

escreva("Digite seu peso: ")
leia(peso)
```

#### Operações matemáticas
```
escreva("Soma: ")
escreva(5.0 + 10)

escreva("Subtração: ")
escreva(5.0 - 10)

escreva("Multiplicação: ")
escreva(5.0 * 10)

escreva("Divisão: ")
escreva(5.0 / 10)

escreva("Exponenciação: ")
escreva(5.0 ^ 10)

escreva("Radiciação: ")
escreva(raiz(4))
```

#### Expressões matemáticas e precedência
##### Ordem de precedência
- 1°: Parênteses 
- 2°: Exponenciação
- 3°: Multiplicação e divisão tem mesmo grau de precedência
- 4°: Soma e subtração tem mesmo grau de precedência

```
escreva(((a / b) + (a * b) - 1))
```

#### Exemplo 
```
inicio

  real b
  real h
  real area

  escreva("Cálculo da área do retângulo")
  escreva("") @@ pular linha

  escreva("Digite a base: ")
  leia(b)

  escreva("Digite a altura: ")
  leia(h)

  escreva("")
  escreva("A área do retângulo é: ")
  area << h * b
  escreva(area)

fim
```

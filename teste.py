# coding: utf-8
import sqlite3

conn = sqlite3.connect("clientes.db")
c = conn.cursor()
sql = "select * from cliente"
c.execute(sql)
dados = c.fetchall()
for dado in dados:
    print (dado[0],dado[1],dado[2],dado[3],dado[4],dado[5],dado[6],dado[7])
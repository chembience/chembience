from django.http import HttpResponse
from django.shortcuts import render

from rdkit import Chem

def resolver(request, smiles):
    mol = Chem.MolFromSmiles(smiles)
   # context = {'inchi': Chem.MolToInchi(mol)}
    return HttpResponse(Chem.MolToInchi(mol))



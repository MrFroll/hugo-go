#!/bin/bash

if [ -z "$SSH_KEY" ] ; then echo SSH key not provided ; else echo $SSH_KEY > /root/.ssh/id_rsa  ; fi
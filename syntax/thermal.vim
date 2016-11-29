" Vim syntax file
" Language: Thermal overlay test
" Maintainer: Liss mccabe
" Latest Revision: eh

if exists("b:current_syntax")
  finish
endif

syntax keyword ThermalLevel1 create_subscription_request
syntax keyword ThermalLevel2 existing_v2_resource
syntax keyword ThermalLevel3 existing_customer_request
syntax keyword ThermalLevel4 provisioning_resource
syntax keyword ThermalLevel5 keyword

highlight ThermalLevel1 guifg=#000000 guibg=#ffffff term=bold gui=bold
highlight ThermalLevel2 guifg=#ffffff guibg=#ffa0a0 term=bold gui=bold
highlight ThermalLevel3 guifg=#ffffff guibg=#ff0000 term=bold gui=bold
highlight ThermalLevel4 guifg=#ffffff guibg=#0f0f00 term=bold gui=bold
highlight ThermalLevel5 guifg=#ffffff guibg=#ff9900 term=bold gui=bold
highlight ThermalLevel6 guifg=#ffffff guibg=#ffdb59 term=bold gui=bold
highlight ThermalLevel7 guifg=#ffffff guibg=#46c57b term=bold gui=bold
highlight ThermalLevel8 guifg=#ffffff guibg=#0045cb term=bold gui=bold
highlight ThermalLevel9 guifg=#ffffff guibg=#5700cb term=bold gui=bold

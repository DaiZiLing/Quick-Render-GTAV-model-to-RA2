rollout unnamedRollout "GTA5 to SHP Vehicle" width:207 height:251
(
							
	
	button 'btn1' "前轮镜像" pos:[8,42] width:89 height:33 align:#left
	
	
	-- End of Button Brace --
		
		Local lujin
	
	--End of Render Progress--
	--spinner 'spn12' "" pos:[60,123] width:139 height:16 range:[-1,9999,0] type:#integer align:#left
	button 'btn2' "后轮镜像" pos:[109,41] width:89 height:33 align:#left
	button 'btn3' "窗户材质" pos:[109,79] width:89 height:33 align:#left
	button 'btn4' "车体材质" pos:[8,79] width:89 height:33 align:#left
	button 'btn5' "轮胎消光" pos:[8,117] width:89 height:33 align:#left
	button 'btn11' "渲染" pos:[109,155] width:89 height:33 align:#left
	label '' "文件名..." pos:[13,209] width:57 height:16 align:#left
	edittext 'edt1' "" pos:[74,197] width:123 height:40 align:#left
	
	button 'btn7' "车内消光" pos:[109,117] width:89 height:33 align:#left
	button 'btn8' "导入" pos:[8,155] width:89 height:33 align:#left
	button 'btn9' "轮胎接地" pos:[8,4] width:89 height:33 align:#left
	
	button 'btn19' "复制轮胎" pos:[109,4] width:89 height:33 align:#left
	
	on btn1 pressed do --前轮胎镜像
	(
		clearSelection()  
	select $_wheel_lf_
	modPanel.addModToSelection (mirror ()) ui:on
	$_wheel_lf_.modifiers[#Mirror].copy = on
		
	---------------------------------------------------------------------------
	)
	on btn2 pressed do --后轮胎镜像
	(
	clearSelection()  --后轮胎镜像
	select $_wheel_lr_
	modPanel.addModToSelection (mirror ()) ui:on
	$_wheel_lr_.modifiers[#Mirror].copy = on
	clearSelection()
	---------------------------------------------------------------------------
	)
	on btn3 pressed do --窗户材质
	(
	clearSelection()
	macros.run "Medit Tools" "clear_medit_slots"  --窗户材质
	meditMaterials[1] = Standardmaterial ()
	meditMaterials[1].Diffuse = color 0 0 0
	meditMaterials[1].ambient = color 0 0 0
	meditMaterials[1].opacity = 60
	meditMaterials[1].name = "Stand 1"
	
	meditMaterials[2] = Standardmaterial ()
	meditMaterials[2].ambient = color 110 110 110
	meditMaterials[2].Diffuse = color 110 110 110
	meditMaterials[2].opacity = 100
	meditMaterials[2].name = "Stand 2"
	meditMaterials[2].useSelfIllumColor = off
	meditMaterials[2].selfIllumColor = color 233 233 233
	
	clearSelection()
	select $wind*
	$.material = meditMaterials[1]
	clearSelection()
	
	select $headlight*
	$.material = meditMaterials[2]
	clearSelection()
	select $taillight*
	$.material = meditMaterials[2]
	clearSelection()
	max quick render
	---------------------------------------------------------------------------
	)
	on btn4 pressed do --车体材质
	(
		
	clearSelection()  --车体材质
	select $bodyshell  
	macros.run "Medit Tools" "clear_medit_slots"
	meditMaterials[1] = $bodyshell.material
	
	meditMaterials[1].material1.specularLevel = 125
	meditMaterials[1].material1.glossiness = 50
	meditMaterials[1].material1.Specular = color 132 132 132
	meditMaterials[1].material1.diffuseMapEnable = on
	meditMaterials[1].material1.diffuseMap = Bitmaptexture fileName:"D:\MOD\gta5 车辆拓展包\yft\vehicle_generic_worn_diff5.png"
	--meditMaterials[1].material1[#Maps][#漫反射颜色__贴图__371__vehicle_generic_worn_diff5_png].alphaSource = 2
	--sceneMaterials["door_pside_r_mso"].material1[#Maps][#漫反射颜色__Bitmaptexture__vehicle_generic_worn_diff5_png].coords.blur = 0.2
	
	--sceneMaterials["vehicle_generic_smallspecmap__PAINT_1_"][#Maps][#漫反射颜色__Bitmaptexture__vehicle_generic_worn_diff5_png].output.rgb_offset = 0.01
	clearSelection()
	max quick render
	
	---------------------------------------------------------------------------
	)
	on btn5 pressed do --轮胎消光
	(
	clearSelection()  --轮胎去除高光
	select $_wheel_lf_
	meditMaterials[7] = $_wheel_lf_.material
	sceneMaterials["_tempvehicle_generic_tyrewallblack"].specularLevel = 20
	clearSelection()
	
	---------------------------------------------------------------------------
	)
	on btn11 pressed do --渲染
	(
		
	clearSelection()
	select $ShadowPlane
	$centerdummy.rotation = quat 0 0 0 1
	$.receiveshadows = off
	select $centerdummy
	for i = 1 to 32 do
	(
	if i < 10 do
	(
		render RA2目标摄像机 frame:#current outputFile:("D:\RA2Scripts\VEH32"+"//"+lujin+" "+"0"+(i as string)+".png") vfb:off
		rotate $ (angleaxis 11.25 [0,0,1])
	)
	if (10<=i) and (i<=99) do
	(
		render RA2目标摄像机 frame:#current outputFile:("D:\RA2Scripts\VEH32"+"//"+lujin+" "+(i as string)+".png") vfb:off
		rotate $ (angleaxis 11.25 [0,0,1])
	)
	)
	clearSelection()
	select $ShadowPlane
	$.receiveshadows = on
	clearSelection()
	select $ShadowPlane
	actionMan.executeAction 0 "40044" 
	meditMaterials[16] = MatteShadow ()
	$.material = meditMaterials[16]
	$.receiveshadows = off
	clearSelection()
	select #($基本光照, $基本光照001, $基本光照002)
	$.renderable = off
	clearSelection()
	select $ShadowPlane
	--actionMan.executeAction 0 "40022"
	$.receiveshadows = on
			clearSelection()
	select $centerdummy
	for i = 33 to 64 do
	(
		render RA2目标摄像机 frame:#current outputFile:("D:\RA2Scripts\VEH32"+"//"+lujin+" "+(i as string)+".png") vfb:off
		rotate $ (angleaxis 11.25 [0,0,1])
	)
	
	--max file open
	
	loadMaxFile "D:\\MOD\\gta5 车辆拓展包\\newmax\\temp.max"
	--checkForSave() = false
	
	---------------------------------------------------------------------------
	)
	on edt1 changed var do
	(
		lujin = var
	)
	on btn7 pressed do --车内消光
	(
	--select $chassis
	meditMaterials[7] = $chassis.material
	$door_pside_f.material.materialList[3].specularLevel = 5
		--sceneMaterials["*interior"].specularLevel = 5
	)
	on btn8 pressed do --导入
	(
			clearSelection()
		max unhide all
		max select all
		max delete
		
	clearSelection()
	importFile "D:\\MOD\\gta5 车辆拓展包\\obj\\temp.obj" #noPrompt
	clearSelection()
		
		--max unfreeze all
		
	)
	on btn9 pressed do --放地上
	(
		clearSelection()
		CenterPivot $_wheel_lf_
		clearSelection()
		select $_wheel_lf_
		$.pivot.z = $.min.z
		clearSelection()
		max select all
		deselect $_wheel_lf_
		max link
		$.parent = $_wheel_lf_
		macros.run "Selection" "SmartSelect"
		clearSelection()
		wheelcordi = $_wheel_lf_.pivot.z
		$_wheel_lf_.pos = $_wheel_lf_.pos + [0,0,-wheelcordi]
		$_wheel_lf_.pivot = [0,0,0]
		clearSelection()
		select $_wheel_lf_.Children
		max unlink
		clearSelection()
		
	)
	
	on btn19 pressed do --复制轮胎
	(
		maxOps.CollapseNode $_wheel_lf_ off
select $_wheel_lf_
	modPanel.addModToSelection (mirror ()) ui:on
	$_wheel_lf_.modifiers[#Mirror].copy = on
$_wheel_lf_.modifiers[#Mirror].mirror_axis = 1
		clearSelection()
	maxOps.CollapseNode $_wheel_lf_ off
	)
)
-- End of Rollout --
 createDialog unnamedRollout
gc()
clearlistener()

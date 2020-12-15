<%@ include file="../jsp/headerFrame.jsp" %>

<h4>Liste des longueurs</h4>

<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#lengthform">Ajouter une longueur</button>

<div class="card mt-1 collapse" id="lengthform">
    <div class="card-body">
        <form method="POST" action="/Escalade/longueur" >

            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="voiefk">Voie :</label>
                <div class="col-sm-10">
                    <select class="custom-select custom-select-sm" name="voiefk" id="voie">
                        <spring:forEach var="voie" items="${ voies }">
                            <option value="<spring:out value="${ voie.id }" />">
                                <spring:out value="${ voie.id }" />
                                -
                                <spring:out value="${ voie.height }" />
                            </option>
                        </spring:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="cotationfk">Cotation :</label>
                <div class="col-sm-10">
                    <select class="custom-select custom-select-sm" name="cotationfk" id="cotation">
                        <spring:forEach var="cotation" items="${ cotations }">
                            <option value="<spring:out value="${ cotation.id }" />">
                                <spring:out value="${ cotation.id }" />
                                -
                                <spring:out value="${ cotation.name }" />
                            </option>
                        </spring:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="numberofspit">Nombre de spit :</label>
                <div class="col-sm-10">
                    <input class="form-control form-control-sm" type="text" name="numberofspit" id="numberofspit" />
                </div>
            </div>

            <button class="btn btn-primary" type="submit">Envoyer</button>

        </form>
    </div>
</div>

<table class="table table-sm table-striped mt-2">
    <spring:forEach var="length" items="${ lengths }">
    <tr>
        <td><spring:out value="${ length.id }" /></td>
        <td><spring:out value="${ length.voieFK.height }" /></td>
        <td><spring:out value="${ length.cotationFK.name }" /></td>
        <td><a href="/Escalade/longueur/<spring:out value="${ length.id }" />" target="_blank">Voir/Editer</a></td>
        <td><a href="/Escalade/longueur/delete/<spring:out value="${ length.id }" />">Supprimer</a></td>
    </tr>
    </spring:forEach>
</table>

<%@ include file="../jsp/footerFrame.jsp" %>